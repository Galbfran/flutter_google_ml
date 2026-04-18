import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:google_ml_kit_test_app/core/router/app_routes.dart';
import 'package:google_ml_kit_test_app/features/example/bloc/example_bloc.dart';
import 'package:google_ml_kit_test_app/features/example/data/repositories/post_repository.dart';
import 'package:google_ml_kit_test_app/features/example/presentation/pages/example_page.dart';
import 'package:google_ml_kit_test_app/features/home/presentation/pages/home_page.dart';
import 'package:google_ml_kit_test_app/features/permissions/presentation/pages/permissions_debug_page.dart';
import 'package:google_ml_kit_test_app/features/splash/bloc/splash_bloc.dart';
import 'package:google_ml_kit_test_app/features/splash/presentation/pages/splash_page.dart';

/// Configuración de navegación. Recibe dependencias que las pantallas necesitan.
final class AppRouter {
  AppRouter(this._postRepository);

  final PostRepository _postRepository;

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
    ],
  );
}
