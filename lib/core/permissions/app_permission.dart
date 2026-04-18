/// Permisos de la app gestionados de forma centralizada.
///
/// Ampliá este enum (p. ej. `photos`) y el mapeo en [PermissionHandlerService].
enum AppPermission {
  camera,
  microphone,
  /// Galería / fotos (image_picker, OCR desde imagen).
  photos,
}
