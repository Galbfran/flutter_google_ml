import 'package:google_ml_kit_test_app/features/text_recognition/model/recognized_text_result.dart';

abstract class TextRecognitionRepository {
  /// `null` si el usuario canceló la selección de imagen.
  Future<RecognizedTextResult?> recognizeFromGallery();

  Future<RecognizedTextResult?> recognizeFromCamera();

  Future<void> dispose();
}
