import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_ml_kit_test_app/features/text_recognition/bloc/text_recognition_bloc.dart';

class TextRecognitionPage extends StatelessWidget {
  const TextRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR (texto en imagen)')),
      body: BlocBuilder<TextRecognitionBloc, TextRecognitionState>(
        builder: (BuildContext context, TextRecognitionState state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: () => context
                          .read<TextRecognitionBloc>()
                          .add(const TextRecognitionGalleryRequested()),
                      icon: const Icon(Icons.photo_library_outlined),
                      label: const Text('Galería'),
                    ),
                    FilledButton.icon(
                      onPressed: () => context
                          .read<TextRecognitionBloc>()
                          .add(const TextRecognitionCameraRequested()),
                      icon: const Icon(Icons.photo_camera_outlined),
                      label: const Text('Cámara'),
                    ),
                    OutlinedButton(
                      onPressed: () => context
                          .read<TextRecognitionBloc>()
                          .add(const TextRecognitionReset()),
                      child: const Text('Limpiar'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: _Body(state: state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final TextRecognitionState state;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      TextRecognitionInitial() => Center(
          child: Text(
            'Elegí una imagen con texto (script latino).',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      TextRecognitionLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
      TextRecognitionSuccess(:final result) => SingleChildScrollView(
          child: SelectableText(
            result.fullText.isEmpty
                ? '(Sin texto detectado)'
                : result.fullText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      TextRecognitionFailure(:final message) => _MessageCard(
          icon: Icons.error_outline,
          color: Theme.of(context).colorScheme.error,
          text: message,
        ),
      TextRecognitionPermissionDenied(:final message) => _MessageCard(
          icon: Icons.lock_outline,
          color: Theme.of(context).colorScheme.tertiary,
          text: message,
        ),
    };
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }
}
