part of 'object_detection_bloc.dart';

sealed class ObjectDetectionState extends Equatable {
  const ObjectDetectionState();

  @override
  List<Object?> get props => [];
}

final class ObjectDetectionInitial extends ObjectDetectionState {
  const ObjectDetectionInitial();
}

final class ObjectDetectionLoading extends ObjectDetectionState {
  const ObjectDetectionLoading();
}

final class ObjectDetectionReady extends ObjectDetectionState {
  const ObjectDetectionReady({
    required this.tick,
    this.frame,
  });

  final int tick;
  final ObjectDetectionFrame? frame;

  @override
  List<Object?> get props => [tick, frame];
}

final class ObjectDetectionPermissionDenied extends ObjectDetectionState {
  const ObjectDetectionPermissionDenied(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class ObjectDetectionFailure extends ObjectDetectionState {
  const ObjectDetectionFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
