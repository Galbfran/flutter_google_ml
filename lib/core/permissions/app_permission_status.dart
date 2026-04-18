/// Estado de un permiso sin acoplar la capa de dominio a `permission_handler`.
enum AppPermissionStatus {
  /// Aún no se consultó o no aplica en esta plataforma.
  unknown,

  granted,
  denied,
  permanentlyDenied,
  restricted,
  limited,
  provisional,
}
