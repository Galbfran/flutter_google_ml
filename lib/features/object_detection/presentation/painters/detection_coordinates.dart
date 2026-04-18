import 'dart:io';
import 'dart:ui' show Size;

import 'package:camera/camera.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

/// Mapea coordenadas de la imagen de ML Kit al tamaño del lienzo del preview.
///
/// Basado en `coordinates_translator.dart` del ejemplo de `google_ml_kit_flutter`.
double translateDetectionX(
  double x,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
      return x *
          canvasSize.width /
          (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation270deg:
      return canvasSize.width -
          x *
              canvasSize.width /
              (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      switch (cameraLensDirection) {
        case CameraLensDirection.back:
          return x * canvasSize.width / imageSize.width;
        case CameraLensDirection.front:
        case CameraLensDirection.external:
          return canvasSize.width - x * canvasSize.width / imageSize.width;
      }
  }
}

double translateDetectionY(
  double y,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
    case InputImageRotation.rotation270deg:
      return y *
          canvasSize.height /
          (Platform.isIOS ? imageSize.height : imageSize.width);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      return y * canvasSize.height / imageSize.height;
  }
}
