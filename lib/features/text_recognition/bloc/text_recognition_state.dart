part of 'text_recognition_bloc.dart';

sealed class TextRecognitionState extends Equatable {
  const TextRecognitionState();

  @override
  List<Object?> get props => [];
}

final class TextRecognitionInitial extends TextRecognitionState {
  const TextRecognitionInitial();
}

final class TextRecognitionLoading extends TextRecognitionState {
  const TextRecognitionLoading();
}

final class TextRecognitionSuccess extends TextRecognitionState {
  const TextRecognitionSuccess(this.result);

  final RecognizedTextResult result;

  @override
  List<Object?> get props => [result];
}

final class TextRecognitionFailure extends TextRecognitionState {
  const TextRecognitionFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class TextRecognitionPermissionDenied extends TextRecognitionState {
  const TextRecognitionPermissionDenied(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
