import 'package:google_ml_kit_test_app/core/media/image_picker_datasource.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/data/datasources/text_recognition_ml_datasource.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/data/repositories/text_recognition_repository.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/model/recognized_text_result.dart';

final class TextRecognitionRepositoryImpl implements TextRecognitionRepository {
  TextRecognitionRepositoryImpl(
    this._imagePicker,
    this._ml,
  );

  final ImagePickerDataSource _imagePicker;
  final TextRecognitionMlDataSource _ml;

  @override
  Future<RecognizedTextResult?> recognizeFromGallery() async {
    final String? path = await _imagePicker.pickFromGallery();
    if (path == null) {
      return null;
    }
    return _ml.recognizeFromFilePath(path);
  }

  @override
  Future<RecognizedTextResult?> recognizeFromCamera() async {
    final String? path = await _imagePicker.pickFromCamera();
    if (path == null) {
      return null;
    }
    return _ml.recognizeFromFilePath(path);
  }

  @override
  Future<void> dispose() => _ml.dispose();
}
