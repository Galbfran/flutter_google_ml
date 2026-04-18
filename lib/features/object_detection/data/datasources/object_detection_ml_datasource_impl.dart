import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

import 'package:google_ml_kit_test_app/features/object_detection/data/datasources/object_detection_ml_datasource.dart';

final class ObjectDetectionMlDataSourceImpl
    implements ObjectDetectionMlDataSource {
  ObjectDetectionMlDataSourceImpl({ObjectDetector? detector})
      : _detector = detector ??
            ObjectDetector(
              options: ObjectDetectorOptions(
                mode: DetectionMode.stream,
                classifyObjects: true,
                multipleObjects: true,
              ),
            );

  final ObjectDetector _detector;
  bool _closed = false;

  @override
  Future<List<DetectedObject>> process(InputImage image) async {
    if (_closed) {
      throw StateError('ObjectDetector ya fue cerrado');
    }
    return _detector.processImage(image);
  }

  @override
  Future<void> dispose() async {
    if (_closed) {
      return;
    }
    _closed = true;
    await _detector.close();
  }
}
