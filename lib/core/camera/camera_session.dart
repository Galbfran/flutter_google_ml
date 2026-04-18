import 'package:camera/camera.dart';

/// Sesión de vista previa y stream de frames (implementación en [CameraSessionImpl]).
abstract class CameraSession {
  bool get isInitialized;

  CameraController get controller;

  List<CameraDescription> get cameras;

  int get cameraIndex;

  CameraDescription get activeDescription;

  Future<void> initialize({CameraLensDirection lens = CameraLensDirection.back});

  Future<void> startImageStream(void Function(CameraImage image) onImage);

  Future<void> stopImageStream();

  Future<void> dispose();
}
