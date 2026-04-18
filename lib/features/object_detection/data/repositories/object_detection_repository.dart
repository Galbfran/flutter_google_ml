import 'package:camera/camera.dart';

import 'package:google_ml_kit_test_app/features/object_detection/model/object_detection_frame.dart';

/// Orquesta cámara + detección y expone frames para la UI.
abstract class ObjectDetectionRepository {
  /// Vista previa cuando la sesión está activa; `null` antes de [start] o tras [stop].
  CameraController? get previewController;

  Stream<ObjectDetectionFrame> get frames;

  /// Inicia cámara y el procesamiento (tras permiso concedido).
  Future<void> start();

  /// Detiene stream y libera la cámara (no cierra el detector ML).
  Future<void> stop();

  Future<void> dispose();
}
