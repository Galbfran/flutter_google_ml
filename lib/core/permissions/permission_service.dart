import 'package:google_ml_kit_test_app/core/permissions/app_permission.dart';
import 'package:google_ml_kit_test_app/core/permissions/app_permission_status.dart';

/// Contrato para comprobar y solicitar permisos del sistema.
abstract class PermissionService {
  Future<AppPermissionStatus> status(AppPermission permission);

  Future<AppPermissionStatus> request(AppPermission permission);

  /// Abre la pantalla de ajustes de la app (cuando el usuario denegó permanentemente).
  Future<bool> openAppSettings();
}
