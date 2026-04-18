import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

/// Abstrae [ObjectDetector] de ML Kit.
abstract class ObjectDetectionMlDataSource {
  Future<List<DetectedObject>> process(InputImage image);

  Future<void> dispose();
}
