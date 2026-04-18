import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:google_ml_kit_test_app/core/media/image_picker_datasource.dart';
import 'package:google_ml_kit_test_app/core/media/image_picker_datasource_exception.dart';
import 'package:google_ml_kit_test_app/core/permissions/app_permission.dart';
import 'package:google_ml_kit_test_app/core/permissions/app_permission_status.dart';
import 'package:google_ml_kit_test_app/core/permissions/permission_service.dart';

final class ImagePickerDataSourceImpl implements ImagePickerDataSource {
  ImagePickerDataSourceImpl({
    required PermissionService permissionService,
    ImagePicker? picker,
  })  : _permissionService = permissionService,
        _picker = picker ?? ImagePicker();

  final PermissionService _permissionService;
  final ImagePicker _picker;

  @override
  Future<String?> pickFromGallery() async {
    await _requirePhotos();
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      return file?.path;
    } on PlatformException catch (e) {
      throw ImagePickerDataSourceException(
        message: e.message ?? 'No se pudo abrir la galería.',
        permissionDenied: _isPermissionRelatedPlatformCode(e.code),
      );
    }
  }

  @override
  Future<String?> pickFromCamera() async {
    await _requireCamera();
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );
      return file?.path;
    } on PlatformException catch (e) {
      throw ImagePickerDataSourceException(
        message: e.message ?? 'No se pudo abrir la cámara.',
        permissionDenied: _isPermissionRelatedPlatformCode(e.code),
      );
    }
  }

  Future<void> _requirePhotos() async {
    final AppPermissionStatus status =
        await _permissionService.request(AppPermission.photos);
    if (!_isPhotosOk(status)) {
      throw ImagePickerDataSourceException(
        message: _photosMessage(status),
        permissionDenied: true,
      );
    }
  }

  Future<void> _requireCamera() async {
    final AppPermissionStatus status =
        await _permissionService.request(AppPermission.camera);
    if (status != AppPermissionStatus.granted) {
      throw ImagePickerDataSourceException(
        message: _cameraMessage(status),
        permissionDenied: true,
      );
    }
  }

  static bool _isPhotosOk(AppPermissionStatus status) {
    return status == AppPermissionStatus.granted ||
        status == AppPermissionStatus.limited;
  }

  static bool _isPermissionRelatedPlatformCode(String code) {
    return switch (code) {
      'photo_access_denied' ||
      'camera_access_denied' ||
      'permission_denied' ||
      'camera_permission_denied' ||
      'photo_library_access_denied' =>
        true,
      _ => false,
    };
  }

  static String _photosMessage(AppPermissionStatus status) {
    return 'Permiso de fotos: ${_statusLabel(status)}. '
        'Concedelo en ajustes para usar la galería.';
  }

  static String _cameraMessage(AppPermissionStatus status) {
    return 'Permiso de cámara: ${_statusLabel(status)}.';
  }

  static String _statusLabel(AppPermissionStatus status) {
    return switch (status) {
      AppPermissionStatus.unknown => 'desconocido',
      AppPermissionStatus.granted => 'concedido',
      AppPermissionStatus.denied => 'denegado',
      AppPermissionStatus.permanentlyDenied => 'denegado permanentemente',
      AppPermissionStatus.restricted => 'restringido',
      AppPermissionStatus.limited => 'limitado',
      AppPermissionStatus.provisional => 'provisional',
    };
  }
}
