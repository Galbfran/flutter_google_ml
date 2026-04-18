import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

import 'package:google_ml_kit_test_app/features/object_detection/model/object_detection_frame.dart';
import 'package:google_ml_kit_test_app/features/object_detection/presentation/painters/detection_coordinates.dart';

/// Dibuja cajas y etiquetas sobre el preview de la cámara.
final class DetectionOverlayPainter extends CustomPainter {
  DetectionOverlayPainter(this.frame);

  final ObjectDetectionFrame frame;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.lightGreenAccent;

    final Paint labelBg = Paint()..color = const Color(0x99000000);

    for (final DetectedObject obj in frame.objects) {
      final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 14,
          textDirection: TextDirection.ltr,
        ),
      );
      builder.pushStyle(
        ui.TextStyle(color: Colors.lightGreenAccent, background: labelBg),
      );
      if (obj.labels.isNotEmpty) {
        final Label label = obj.labels.reduce(
          (Label a, Label b) => a.confidence > b.confidence ? a : b,
        );
        builder.addText('${label.text} (${label.confidence.toStringAsFixed(2)})\n');
      } else if (obj.trackingId != null) {
        builder.addText('#${obj.trackingId}\n');
      }
      builder.pop();

      final double left = translateDetectionX(
        obj.boundingBox.left,
        size,
        frame.imageSize,
        frame.rotation,
        frame.lensDirection,
      );
      final double top = translateDetectionY(
        obj.boundingBox.top,
        size,
        frame.imageSize,
        frame.rotation,
        frame.lensDirection,
      );
      final double right = translateDetectionX(
        obj.boundingBox.right,
        size,
        frame.imageSize,
        frame.rotation,
        frame.lensDirection,
      );
      final double bottom = translateDetectionY(
        obj.boundingBox.bottom,
        size,
        frame.imageSize,
        frame.rotation,
        frame.lensDirection,
      );

      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), boxPaint);

      final ui.Paragraph paragraph = builder.build()
        ..layout(ui.ParagraphConstraints(width: (right - left).abs()));

      canvas.drawParagraph(
        paragraph,
        Offset(
          Platform.isAndroid &&
                  frame.lensDirection == CameraLensDirection.front
              ? right
              : left,
          top,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant DetectionOverlayPainter oldDelegate) {
    return oldDelegate.frame != frame;
  }
}
