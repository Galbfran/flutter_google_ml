import 'package:google_ml_kit_test_app/features/example/model/post.dart';

abstract class PostRepository {
  Future<Post> getPostById(int id);
}
