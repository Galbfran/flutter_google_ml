import 'package:permission_handler/permission_handler.dart' as ph;

import 'package:google_ml_kit_test_app/core/permissions/app_permission.dart';
import 'package:google_ml_kit_test_app/core/permissions/app_permission_status.dart';
import 'package:google_ml_kit_test_app/core/permissions/permission_service.dart';

/// Implementación con el paquete `permission_handler`.
final class PermissionHandlerService implements PermissionService {
  @override
  Future<AppPermissionStatus> status(AppPermission permission) async {
    final ph.Permission p = _map(permission);
    final ph.PermissionStatus s = await p.status;
    return _mapStatus(s);
  }

  @override
  Future<AppPermissionStatus> request(AppPermission permission) async {
    final ph.Permission p = _map(permission);
    final ph.PermissionStatus s = await p.request();
    return _mapStatus(s);
  }

  @override
  Future<bool> openAppSettings() => ph.openAppSettings();

  ph.Permission _map(AppPermission permission) {
    return switch (permission) {
      AppPermission.camera => ph.Permission.camera,
      AppPermission.microphone => ph.Permission.microphone,
    };
  }

  AppPermissionStatus _mapStatus(ph.PermissionStatus status) {
    return switch (status) {
      ph.PermissionStatus.granted => AppPermissionStatus.granted,
      ph.PermissionStatus.denied => AppPermissionStatus.denied,
      ph.PermissionStatus.permanentlyDenied =>
        AppPermissionStatus.permanentlyDenied,
      ph.PermissionStatus.restricted => AppPermissionStatus.restricted,
      ph.PermissionStatus.limited => AppPermissionStatus.limited,
      ph.PermissionStatus.provisional => AppPermissionStatus.provisional,
    };
  }
}
