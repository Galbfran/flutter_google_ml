import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

/// Resultado de convertir un [CameraImage] del plugin `camera` a [InputImage] de ML Kit.
final class CameraMlConversionResult {
  const CameraMlConversionResult({
    required this.inputImage,
    required this.rotation,
    required this.imageSize,
  });

  final InputImage inputImage;
  final InputImageRotation rotation;
  final Size imageSize;
}

const Map<DeviceOrientation, int> _orientations = <DeviceOrientation, int>{
  DeviceOrientation.portraitUp: 0,
  DeviceOrientation.landscapeLeft: 90,
  DeviceOrientation.portraitDown: 180,
  DeviceOrientation.landscapeRight: 270,
};

/// Convierte un frame de la cámara al formato que espera ML Kit.
///
/// Basado en el ejemplo oficial de `google_ml_kit_flutter` (`camera_view.dart`).
CameraMlConversionResult? cameraImageToMlInput({
  required CameraImage image,
  required CameraController controller,
  required CameraDescription camera,
}) {
  final int sensorOrientation = camera.sensorOrientation;
  InputImageRotation? rotation;
  if (Platform.isIOS) {
    rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
  } else if (Platform.isAndroid) {
    int? rotationCompensation =
        _orientations[controller.value.deviceOrientation];
    if (rotationCompensation == null) {
      return null;
    }
    if (camera.lensDirection == CameraLensDirection.front) {
      rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
    } else {
      rotationCompensation =
          (sensorOrientation - rotationCompensation + 360) % 360;
    }
    rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
  }
  if (rotation == null) {
    return null;
  }

  final InputImageFormat? format =
      InputImageFormatValue.fromRawValue(image.format.raw);
  if (format == null ||
      (Platform.isAndroid && format != InputImageFormat.nv21) ||
      (Platform.isIOS && format != InputImageFormat.bgra8888)) {
    return null;
  }

  if (image.planes.length != 1) {
    return null;
  }
  final Plane plane = image.planes.first;
  final InputImage inputImage = InputImage.fromBytes(
    bytes: plane.bytes,
    metadata: InputImageMetadata(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      format: format,
      bytesPerRow: plane.bytesPerRow,
    ),
  );

  return CameraMlConversionResult(
    inputImage: inputImage,
    rotation: rotation,
    imageSize: Size(image.width.toDouble(), image.height.toDouble()),
  );
}
