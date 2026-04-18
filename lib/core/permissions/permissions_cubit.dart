import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_ml_kit_test_app/core/permissions/app_permission.dart';
import 'package:google_ml_kit_test_app/core/permissions/permission_service.dart';
import 'package:google_ml_kit_test_app/core/permissions/permissions_state.dart';

/// Cubit global: consulta y solicita permisos vía [PermissionService].
///
/// Los BLoCs **por pantalla** (splash, example, OCR) siguen siendo locales en el router.
final class PermissionsCubit extends Cubit<PermissionsState> {
  PermissionsCubit(this._service) : super(const PermissionsState());

  final PermissionService _service;

  /// Refresca todos los permisos conocidos (llamar al iniciar o al volver de ajustes).
  Future<void> refreshAll() async {
    final camera = await _service.status(AppPermission.camera);
    final microphone = await _service.status(AppPermission.microphone);
    emit(state.copyWith(camera: camera, microphone: microphone));
  }

  Future<void> requestCamera() async {
    final camera = await _service.request(AppPermission.camera);
    emit(state.copyWith(camera: camera));
  }

  Future<void> requestMicrophone() async {
    final microphone = await _service.request(AppPermission.microphone);
    emit(state.copyWith(microphone: microphone));
  }

  Future<void> openAppSettings() async {
    await _service.openAppSettings();
    await refreshAll();
  }
}
