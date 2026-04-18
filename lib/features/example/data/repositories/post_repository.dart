import 'package:google_ml_kit/features/example/model/post.dart';

abstract class PostRepository {
  Future<Post> getPostById(int id);
}
