import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:google_ml_kit_test_app/core/camera/camera_session_impl.dart';
import 'package:google_ml_kit_test_app/core/permissions/permission_service.dart';
import 'package:google_ml_kit_test_app/core/router/app_routes.dart';
import 'package:google_ml_kit_test_app/features/example/bloc/example_bloc.dart';
import 'package:google_ml_kit_test_app/features/example/data/repositories/post_repository.dart';
import 'package:google_ml_kit_test_app/features/example/presentation/pages/example_page.dart';
import 'package:google_ml_kit_test_app/features/home/presentation/pages/home_page.dart';
import 'package:google_ml_kit_test_app/features/object_detection/bloc/object_detection_bloc.dart';
import 'package:google_ml_kit_test_app/features/object_detection/data/datasources/object_detection_ml_datasource_impl.dart';
import 'package:google_ml_kit_test_app/features/object_detection/data/repositories/object_detection_repository.dart';
import 'package:google_ml_kit_test_app/features/object_detection/data/repositories/object_detection_repository_impl.dart';
import 'package:google_ml_kit_test_app/features/object_detection/presentation/pages/object_detection_page.dart';
import 'package:google_ml_kit_test_app/features/permissions/presentation/pages/permissions_debug_page.dart';
import 'package:google_ml_kit_test_app/features/splash/bloc/splash_bloc.dart';
import 'package:google_ml_kit_test_app/features/splash/presentation/pages/splash_page.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/bloc/text_recognition_bloc.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/data/repositories/text_recognition_repository.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/presentation/pages/text_recognition_page.dart';

/// Configuración de navegación. Recibe dependencias que las pantallas necesitan.
final class AppRouter {
  AppRouter({
    required PostRepository postRepository,
    required TextRecognitionRepository textRecognitionRepository,
    required PermissionService permissionService,
  })  : _postRepository = postRepository,
        _textRecognitionRepository = textRecognitionRepository,
        _permissionService = permissionService;

  final PostRepository _postRepository;
  final TextRecognitionRepository _textRecognitionRepository;
  final PermissionService _permissionService;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (_) => SplashBloc()..add(const SplashStarted()),
            child: const SplashPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: AppRoutes.example,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (_) => ExampleBloc(repository: _postRepository)
              ..add(const ExampleLoadRequested()),
            child: const ExamplePage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.permissionsDebug,
        builder: (BuildContext context, GoRouterState state) {
          return const PermissionsDebugPage();
        },
      ),
      GoRoute(
        path: AppRoutes.textRecognition,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (_) =>
                TextRecognitionBloc(repository: _textRecognitionRepository),
            child: const TextRecognitionPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.objectDetection,
        builder: (BuildContext context, GoRouterState state) {
          final ObjectDetectionRepository repository =
              ObjectDetectionRepositoryImpl(
            permissionService: _permissionService,
            cameraSession: CameraSessionImpl(),
            mlDataSource: ObjectDetectionMlDataSourceImpl(),
          );
          return MultiProvider(
            providers: [
              Provider<ObjectDetectionRepository>.value(value: repository),
            ],
            child: BlocProvider(
              create: (_) => ObjectDetectionBloc(repository: repository)
                ..add(const ObjectDetectionStarted()),
              child: const ObjectDetectionPage(),
            ),
          );
        },
      ),
    ],
  );
}
