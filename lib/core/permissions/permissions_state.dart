import 'package:equatable/equatable.dart';

import 'package:google_ml_kit_test_app/core/permissions/app_permission_status.dart';

/// Estado agregado de permisos globales (ampliá campos al sumar [AppPermission]).
final class PermissionsState extends Equatable {
  const PermissionsState({
    this.camera = AppPermissionStatus.unknown,
    this.microphone = AppPermissionStatus.unknown,
  });

  final AppPermissionStatus camera;
  final AppPermissionStatus microphone;

  PermissionsState copyWith({
    AppPermissionStatus? camera,
    AppPermissionStatus? microphone,
  }) {
    return PermissionsState(
      camera: camera ?? this.camera,
      microphone: microphone ?? this.microphone,
    );
  }

  @override
  List<Object?> get props => [camera, microphone];
}
