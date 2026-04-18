import 'package:flutter/material.dart';

import 'package:google_ml_kit/app.dart';
import 'package:google_ml_kit/core/config/app_config.dart';
import 'package:google_ml_kit/core/network/dio_client.dart';
import 'package:google_ml_kit/core/router/app_router.dart';
import 'package:google_ml_kit/features/example/data/datasources/post_remote_datasource.dart';
import 'package:google_ml_kit/features/example/data/repositories/post_repository_impl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = DioClient(baseUrl: AppConfig.apiBaseUrl).create();
  final postRepository = PostRepositoryImpl(
    PostRemoteDataSourceImpl(dio),
  );
  final appRouter = AppRouter(postRepository);

  runApp(App(routerConfig: appRouter.router));
}
