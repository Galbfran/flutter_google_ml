part of 'object_detection_bloc.dart';

sealed class ObjectDetectionEvent extends Equatable {
  const ObjectDetectionEvent();

  @override
  List<Object?> get props => [];
}

final class ObjectDetectionStarted extends ObjectDetectionEvent {
  const ObjectDetectionStarted();
}

final class ObjectDetectionFrameReceived extends ObjectDetectionEvent {
  const ObjectDetectionFrameReceived(this.frame);

  final ObjectDetectionFrame frame;

  @override
  List<Object?> get props => [frame];
}
