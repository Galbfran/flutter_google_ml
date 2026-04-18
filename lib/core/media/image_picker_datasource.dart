/// Abstrae el paquete [image_picker] (galería / cámara).
///
/// Vive en `core` para reutilizarlo en cualquier feature (OCR, perfil, adjuntos, etc.).
abstract class ImagePickerDataSource {
  /// Devuelve la ruta del archivo o `null` si el usuario canceló.
  Future<String?> pickFromGallery();

  Future<String?> pickFromCamera();
}
