import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_ml_kit_test_app/app.dart';
import 'package:google_ml_kit_test_app/core/bloc/global_bloc_providers.dart';
import 'package:google_ml_kit_test_app/core/config/app_config.dart';
import 'package:google_ml_kit_test_app/core/network/dio_client.dart';
import 'package:google_ml_kit_test_app/core/permissions/permission_handler_service.dart';
import 'package:google_ml_kit_test_app/core/permissions/permission_service.dart';
import 'package:google_ml_kit_test_app/core/router/app_router.dart';
import 'package:google_ml_kit_test_app/features/example/data/datasources/post_remote_datasource.dart';
import 'package:google_ml_kit_test_app/features/example/data/repositories/post_repository_impl.dart';
import 'package:google_ml_kit_test_app/core/media/image_picker_datasource_impl.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/data/datasources/text_recognition_ml_datasource_impl.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/data/repositories/text_recognition_repository_impl.dart';

/// Arranque de la app: composición de dependencias + [MultiBlocProvider] global.
///
/// Si pasás [appRouter] (p. ej. en tests o con mocks), se usa ese; si no, se
/// construye el grafo por defecto.
final class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key, AppRouter? appRouter}) : _appRouter = appRouter;

  final AppRouter? _appRouter;

  @override
  Widget build(BuildContext context) {
    final PermissionHandlerService permissionService = PermissionHandlerService();
    final AppRouter appRouter =
        _appRouter ?? _createDefaultRouter(permissionService);

    return MultiBlocProvider(
      providers: buildGlobalBlocProviders(
        permissionService: permissionService,
      ),
      child: App(routerConfig: appRouter.router),
    );
  }

  static AppRouter _createDefaultRouter(PermissionService permissionService) {
    final dio = DioClient(baseUrl: AppConfig.apiBaseUrl).create();
    final postRepository = PostRepositoryImpl(
      PostRemoteDataSourceImpl(dio),
    );
    final textRecognitionRepository = TextRecognitionRepositoryImpl(
      ImagePickerDataSourceImpl(permissionService: permissionService),
      TextRecognitionMlDataSourceImpl(),
    );
    return AppRouter(
      postRepository: postRepository,
      textRecognitionRepository: textRecognitionRepository,
      permissionService: permissionService,
    );
  }
}
