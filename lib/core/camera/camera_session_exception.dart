/// Fallo al usar la sesión de cámara (permisos, hardware, etc.).
final class CameraSessionException implements Exception {
  CameraSessionException({
    required this.message,
    this.permissionDenied = false,
  });

  final String message;
  final bool permissionDenied;

  @override
  String toString() => message;
}
