import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_ml_kit_test_app/features/object_detection/bloc/object_detection_bloc.dart';
import 'package:google_ml_kit_test_app/features/object_detection/data/repositories/object_detection_repository.dart';
import 'package:google_ml_kit_test_app/features/object_detection/model/object_detection_frame.dart';
import 'package:google_ml_kit_test_app/features/object_detection/presentation/painters/detection_overlay_painter.dart';

class ObjectDetectionPage extends StatelessWidget {
  const ObjectDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Objetos en vivo (ML Kit)'),
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<ObjectDetectionBloc, ObjectDetectionState>(
        builder: (BuildContext context, ObjectDetectionState state) {
          return switch (state) {
            ObjectDetectionInitial() => const Center(
                child: CircularProgressIndicator(),
              ),
            ObjectDetectionLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ObjectDetectionPermissionDenied(:final String message) =>
              _MessageCenter(
                icon: Icons.lock_outline,
                text: message,
              ),
            ObjectDetectionFailure(:final String message) => _MessageCenter(
                icon: Icons.error_outline,
                text: message,
              ),
            ObjectDetectionReady(:final ObjectDetectionFrame? frame) =>
              _LivePreview(
                frame: frame,
              ),
          };
        },
      ),
    );
  }
}

class _LivePreview extends StatelessWidget {
  const _LivePreview({required this.frame});

  final ObjectDetectionFrame? frame;

  @override
  Widget build(BuildContext context) {
    final ObjectDetectionRepository repository =
        context.read<ObjectDetectionRepository>();
    final CameraController? controller = repository.previewController;
    if (controller == null || !controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: CameraPreview(controller),
          ),
          if (frame != null)
            CustomPaint(
              painter: DetectionOverlayPainter(frame!),
            ),
        ],
      ),
    );
  }
}

class _MessageCenter extends StatelessWidget {
  const _MessageCenter({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.error),
                const SizedBox(width: 12),
                Expanded(child: Text(text)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
