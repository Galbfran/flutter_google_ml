/// DTO de respuesta para GET `/posts/:id` (jsonplaceholder).
final class PostResponseDto {
  const PostResponseDto({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostResponseDto.fromJson(Map<String, dynamic> json) {
    return PostResponseDto(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  final int userId;
  final int id;
  final String title;
  final String body;
}
