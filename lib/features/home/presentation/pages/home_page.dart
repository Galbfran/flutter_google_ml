import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_ml_kit_test_app/core/router/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pantalla principal'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.push(AppRoutes.example),
              child: const Text('Ir a Example (Dio + DTO)'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.push(AppRoutes.permissionsDebug),
              child: const Text('Lab permisos (cámara)'),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: () => context.push(AppRoutes.textRecognition),
              child: const Text('OCR (imagen → texto)'),
            ),
          ],
        ),
      ),
    );
  }
}
