import 'package:google_ml_kit_test_app/features/text_recognition/model/recognized_text_result.dart';

/// Abstrae [google_mlkit_text_recognition].
abstract class TextRecognitionMlDataSource {
  Future<RecognizedTextResult> recognizeFromFilePath(String path);

  Future<void> dispose();
}
