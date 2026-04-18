import 'dart:ui' show Size;

import 'package:camera/camera.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

/// Un frame de resultados de detección alineado con la imagen de la cámara.
final class ObjectDetectionFrame {
  const ObjectDetectionFrame({
    required this.objects,
    required this.imageSize,
    required this.rotation,
    required this.lensDirection,
  });

  final List<DetectedObject> objects;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection lensDirection;
}
