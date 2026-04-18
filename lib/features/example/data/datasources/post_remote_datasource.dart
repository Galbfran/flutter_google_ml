import 'package:dio/dio.dart';

import 'package:google_ml_kit/features/example/data/models/post_response_dto.dart';

abstract class PostRemoteDataSource {
  Future<PostResponseDto> fetchPost(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  PostRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<PostResponseDto> fetchPost(int id) async {
    final Response<Map<String, dynamic>> response =
        await _dio.get<Map<String, dynamic>>('/posts/$id');
    final data = response.data;
    if (data == null) {
      throw StateError('Respuesta vacía para /posts/$id');
    }
    return PostResponseDto.fromJson(data);
  }
}
