import 'package:google_ml_kit/features/example/data/datasources/post_remote_datasource.dart';
import 'package:google_ml_kit/features/example/data/repositories/post_repository.dart';
import 'package:google_ml_kit/features/example/model/post.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._remote);

  final PostRemoteDataSource _remote;

  @override
  Future<Post> getPostById(int id) async {
    final dto = await _remote.fetchPost(id);
    return Post(
      id: dto.id,
      title: dto.title,
      body: dto.body,
    );
  }
}
