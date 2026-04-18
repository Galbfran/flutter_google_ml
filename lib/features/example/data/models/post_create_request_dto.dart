/// Ejemplo de DTO de **envío** para POST `/posts` (misma API de demo).
///
/// La pantalla Example solo hace GET; este archivo sirve como plantilla
/// para `dio.post(..., data: request.toJson())`.
final class PostCreateRequestDto {
  const PostCreateRequestDto({
    required this.title,
    required this.body,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'userId': userId,
      };

  final String title;
  final String body;
  final int userId;
}
