import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:google_ml_kit_test_app/features/text_recognition/data/datasources/text_recognition_ml_datasource.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/model/recognized_text_result.dart';

final class TextRecognitionMlDataSourceImpl implements TextRecognitionMlDataSource {
  TextRecognitionMlDataSourceImpl({
    TextRecognizer? recognizer,
  }) : _recognizer = recognizer ??
            TextRecognizer(script: TextRecognitionScript.latin);

  final TextRecognizer _recognizer;
  bool _closed = false;

  @override
  Future<RecognizedTextResult> recognizeFromFilePath(String path) async {
    if (_closed) {
      throw StateError('TextRecognizer ya fue cerrado');
    }
    final InputImage image = InputImage.fromFilePath(path);
    final RecognizedText recognized = await _recognizer.processImage(image);
    final List<String> lines = <String>[];
    for (final TextBlock block in recognized.blocks) {
      for (final TextLine line in block.lines) {
        lines.add(line.text);
      }
    }
    return RecognizedTextResult(
      fullText: recognized.text,
      lines: lines,
    );
  }

  @override
  Future<void> dispose() async {
    if (_closed) {
      return;
    }
    _closed = true;
    await _recognizer.close();
  }
}
