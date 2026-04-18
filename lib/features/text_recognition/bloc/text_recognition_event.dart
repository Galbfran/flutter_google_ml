part of 'text_recognition_bloc.dart';

sealed class TextRecognitionEvent extends Equatable {
  const TextRecognitionEvent();

  @override
  List<Object?> get props => [];
}

final class TextRecognitionGalleryRequested extends TextRecognitionEvent {
  const TextRecognitionGalleryRequested();
}

final class TextRecognitionCameraRequested extends TextRecognitionEvent {
  const TextRecognitionCameraRequested();
}

final class TextRecognitionReset extends TextRecognitionEvent {
  const TextRecognitionReset();
}
