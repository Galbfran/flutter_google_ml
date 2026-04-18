/// Error al elegir imagen (permiso denegado, fallo de plataforma, etc.).
///
/// La cancelación del usuario no lanza excepción: el datasource devuelve `null`.
final class ImagePickerDataSourceException implements Exception {
  ImagePickerDataSourceException({
    required this.message,
    this.permissionDenied = false,
  });

  final String message;
  final bool permissionDenied;

  @override
  String toString() => message;
}
