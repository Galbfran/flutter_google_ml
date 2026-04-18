import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_ml_kit_test_app/core/permissions/app_permission_status.dart';
import 'package:google_ml_kit_test_app/core/permissions/permissions_cubit.dart';
import 'package:google_ml_kit_test_app/core/permissions/permissions_state.dart';

/// Pantalla de laboratorio para probar el [PermissionsCubit] global.
///
/// Por ahora solo expone acciones de **cámara**; el micrófono se muestra como estado.
class PermissionsDebugPage extends StatelessWidget {
  const PermissionsDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permisos (lab)')),
      body: BlocBuilder<PermissionsCubit, PermissionsState>(
        builder: (BuildContext context, PermissionsState state) {
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Cámara: ${_label(state.camera)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () =>
                    context.read<PermissionsCubit>().requestCamera(),
                child: const Text('Solicitar cámara'),
              ),
              const SizedBox(height: 32),
              Text(
                'Micrófono: ${_label(state.microphone)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Acciones de micrófono se pueden añadir aquí cuando integres audio.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () =>
                    context.read<PermissionsCubit>().refreshAll(),
                child: const Text('Actualizar estado'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () =>
                    context.read<PermissionsCubit>().openAppSettings(),
                child: const Text('Abrir ajustes de la app'),
              ),
            ],
          );
        },
      ),
    );
  }

  static String _label(AppPermissionStatus s) {
    return switch (s) {
      AppPermissionStatus.unknown => 'desconocido',
      AppPermissionStatus.granted => 'concedido',
      AppPermissionStatus.denied => 'denegado',
      AppPermissionStatus.permanentlyDenied => 'denegado (permanente)',
      AppPermissionStatus.restricted => 'restringido',
      AppPermissionStatus.limited => 'limitado',
      AppPermissionStatus.provisional => 'provisional',
    };
  }
}
