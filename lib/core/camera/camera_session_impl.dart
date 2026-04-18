import 'dart:io';

import 'package:camera/camera.dart';

import 'package:google_ml_kit_test_app/core/camera/camera_session.dart';
import 'package:google_ml_kit_test_app/core/camera/camera_session_exception.dart';

final class CameraSessionImpl implements CameraSession {
  List<CameraDescription> _cameras = const [];
  int _cameraIndex = -1;
  CameraController? _controller;

  @override
  bool get isInitialized => _controller?.value.isInitialized ?? false;

  @override
  CameraController get controller {
    final CameraController? c = _controller;
    if (c == null || !c.value.isInitialized) {
      throw CameraSessionException(message: 'La cámara no está inicializada');
    }
    return c;
  }

  @override
  List<CameraDescription> get cameras => _cameras;

  @override
  int get cameraIndex => _cameraIndex;

  @override
  CameraDescription get activeDescription => _cameras[_cameraIndex];

  @override
  Future<void> initialize({
    CameraLensDirection lens = CameraLensDirection.back,
  }) async {
    _cameras = await availableCameras();
    if (_cameras.isEmpty) {
      throw CameraSessionException(message: 'No hay cámaras disponibles');
    }
    final int idx = _cameras.indexWhere((CameraDescription c) {
      return c.lensDirection == lens;
    });
    _cameraIndex = idx >= 0 ? idx : 0;
    final CameraDescription cam = _cameras[_cameraIndex];
    _controller = CameraController(
      cam,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    await _controller!.initialize();
  }

  @override
  Future<void> startImageStream(void Function(CameraImage image) onImage) async {
    await controller.startImageStream(onImage);
  }

  @override
  Future<void> stopImageStream() async {
    final CameraController? c = _controller;
    if (c == null) {
      return;
    }
    try {
      await c.stopImageStream();
    } on CameraException {
      // Ya detenido o controlador en transición.
    }
  }

  @override
  Future<void> dispose() async {
    await stopImageStream();
    await _controller?.dispose();
    _controller = null;
    _cameraIndex = -1;
    _cameras = const [];
  }
}
