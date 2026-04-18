import 'dart:async';

import 'package:camera/camera.dart';

import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

import 'package:google_ml_kit_test_app/core/camera/camera_session.dart';
import 'package:google_ml_kit_test_app/core/camera/camera_session_exception.dart';
import 'package:google_ml_kit_test_app/core/camera/camera_to_input_image.dart';
import 'package:google_ml_kit_test_app/core/permissions/app_permission.dart';
import 'package:google_ml_kit_test_app/core/permissions/app_permission_status.dart';
import 'package:google_ml_kit_test_app/core/permissions/permission_service.dart';
import 'package:google_ml_kit_test_app/features/object_detection/data/datasources/object_detection_ml_datasource.dart';
import 'package:google_ml_kit_test_app/features/object_detection/data/repositories/object_detection_repository.dart';
import 'package:google_ml_kit_test_app/features/object_detection/model/object_detection_frame.dart';

final class ObjectDetectionRepositoryImpl implements ObjectDetectionRepository {
  ObjectDetectionRepositoryImpl({
    required PermissionService permissionService,
    required CameraSession cameraSession,
    required ObjectDetectionMlDataSource mlDataSource,
    this.processEveryNFrames = 3,
  })  : _permission = permissionService,
        _camera = cameraSession,
        _ml = mlDataSource;

  final PermissionService _permission;
  final CameraSession _camera;
  final ObjectDetectionMlDataSource _ml;
  final int processEveryNFrames;

  final StreamController<ObjectDetectionFrame> _frameController =
      StreamController<ObjectDetectionFrame>.broadcast();

  bool _started = false;
  bool _disposed = false;
  bool _busy = false;
  int _frameTick = 0;

  @override
  Stream<ObjectDetectionFrame> get frames => _frameController.stream;

  @override
  CameraController? get previewController {
    if (!_started || !_camera.isInitialized) {
      return null;
    }
    try {
      return _camera.controller;
    } on CameraSessionException {
      return null;
    }
  }

  @override
  Future<void> start() async {
    if (_started) {
      return;
    }
    final AppPermissionStatus status =
        await _permission.request(AppPermission.camera);
    if (status != AppPermissionStatus.granted) {
      throw CameraSessionException(
        message: 'Se necesita permiso de cámara para la detección en vivo.',
        permissionDenied: true,
      );
    }

    await _camera.initialize();
    _frameTick = 0;

    try {
      await _camera.startImageStream(_onCameraImage);
      _started = true;
    } on Object {
      await _camera.dispose();
      rethrow;
    }
  }

  Future<void> _onCameraImage(CameraImage image) async {
    if (!_started || _busy) {
      return;
    }
    _frameTick++;
    if (_frameTick % processEveryNFrames != 0) {
      return;
    }

    final CameraMlConversionResult? conversion = cameraImageToMlInput(
      image: image,
      controller: _camera.controller,
      camera: _camera.activeDescription,
    );
    if (conversion == null) {
      return;
    }

    _busy = true;
    try {
      final List<DetectedObject> objects =
          await _ml.process(conversion.inputImage);
      if (_frameController.isClosed) {
        return;
      }
      _frameController.add(
        ObjectDetectionFrame(
          objects: objects,
          imageSize: conversion.imageSize,
          rotation: conversion.rotation,
          lensDirection: _camera.activeDescription.lensDirection,
        ),
      );
    } on Object {
      // Evita tumbar el stream por un frame defectuoso.
    } finally {
      _busy = false;
    }
  }

  @override
  Future<void> stop() async {
    if (!_started) {
      return;
    }
    _started = false;
    await _camera.stopImageStream();
    await _camera.dispose();
  }

  @override
  Future<void> dispose() async {
    if (_disposed) {
      return;
    }
    _disposed = true;
    await stop();
    await _ml.dispose();
    await _frameController.close();
  }
}
