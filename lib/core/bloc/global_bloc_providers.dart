import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import 'package:google_ml_kit_test_app/core/permissions/permission_service.dart';
import 'package:google_ml_kit_test_app/core/permissions/permissions_cubit.dart';

/// BLoCs/Cubits **globales** (disponibles bajo todo el árbol con `context.read` / `BlocBuilder`).
///
/// Los providers **locales** por ruta siguen en `AppRouter` (splash, example, OCR, etc.).
List<SingleChildWidget> buildGlobalBlocProviders({
  required PermissionService permissionService,
}) {
  return <SingleChildWidget>[
    BlocProvider<PermissionsCubit>(
      create: (_) => PermissionsCubit(permissionService)..refreshAll(),
    ),
  ];
}
