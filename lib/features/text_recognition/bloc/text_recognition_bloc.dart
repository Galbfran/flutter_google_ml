import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:google_ml_kit_test_app/core/media/image_picker_datasource_exception.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/data/repositories/text_recognition_repository.dart';
import 'package:google_ml_kit_test_app/features/text_recognition/model/recognized_text_result.dart';

part 'text_recognition_event.dart';
part 'text_recognition_state.dart';

final class TextRecognitionBloc
    extends Bloc<TextRecognitionEvent, TextRecognitionState> {
  TextRecognitionBloc({
    required TextRecognitionRepository repository,
  })  : _repository = repository,
        super(const TextRecognitionInitial()) {
    on<TextRecognitionGalleryRequested>(_onGalleryRequested);
    on<TextRecognitionCameraRequested>(_onCameraRequested);
    on<TextRecognitionReset>(_onReset);
  }

  final TextRecognitionRepository _repository;

  Future<void> _onGalleryRequested(
    TextRecognitionGalleryRequested event,
    Emitter<TextRecognitionState> emit,
  ) async {
    emit(const TextRecognitionLoading());
    try {
      final RecognizedTextResult? result =
          await _repository.recognizeFromGallery();
      if (result == null) {
        emit(const TextRecognitionInitial());
        return;
      }
      emit(TextRecognitionSuccess(result));
    } on ImagePickerDataSourceException catch (e) {
      if (e.permissionDenied) {
        emit(TextRecognitionPermissionDenied(e.message));
      } else {
        emit(TextRecognitionFailure(e.message));
      }
    } on Object catch (e) {
      emit(TextRecognitionFailure(e.toString()));
    }
  }

  Future<void> _onCameraRequested(
    TextRecognitionCameraRequested event,
    Emitter<TextRecognitionState> emit,
  ) async {
    emit(const TextRecognitionLoading());
    try {
      final RecognizedTextResult? result =
          await _repository.recognizeFromCamera();
      if (result == null) {
        emit(const TextRecognitionInitial());
        return;
      }
      emit(TextRecognitionSuccess(result));
    } on ImagePickerDataSourceException catch (e) {
      if (e.permissionDenied) {
        emit(TextRecognitionPermissionDenied(e.message));
      } else {
        emit(TextRecognitionFailure(e.message));
      }
    } on Object catch (e) {
      emit(TextRecognitionFailure(e.toString()));
    }
  }

  void _onReset(
    TextRecognitionReset event,
    Emitter<TextRecognitionState> emit,
  ) {
    emit(const TextRecognitionInitial());
  }

  /// No se llama a [TextRecognitionRepository.dispose]: el repositorio y el
  /// [TextRecognizer] viven en el ámbito de la app (ver [AppBootstrap]) y se
  /// comparten entre visitas a esta pantalla; cerrarlos aquí dejaría el OCR
  /// inutilizable hasta reiniciar la app.
  @override
  Future<void> close() async => super.close();
}
