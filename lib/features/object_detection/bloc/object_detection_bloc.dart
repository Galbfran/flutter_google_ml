import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_ml_kit_test_app/core/camera/camera_session_exception.dart';
import 'package:google_ml_kit_test_app/features/object_detection/data/repositories/object_detection_repository.dart';
import 'package:google_ml_kit_test_app/features/object_detection/model/object_detection_frame.dart';

part 'object_detection_event.dart';
part 'object_detection_state.dart';

final class ObjectDetectionBloc
    extends Bloc<ObjectDetectionEvent, ObjectDetectionState> {
  ObjectDetectionBloc({
    required ObjectDetectionRepository repository,
  })  : _repository = repository,
        super(const ObjectDetectionInitial()) {
    on<ObjectDetectionStarted>(_onStarted);
    on<ObjectDetectionFrameReceived>(_onFrameReceived);
  }

  final ObjectDetectionRepository _repository;
  StreamSubscription<ObjectDetectionFrame>? _subscription;

  Future<void> _onStarted(
    ObjectDetectionStarted event,
    Emitter<ObjectDetectionState> emit,
  ) async {
    emit(const ObjectDetectionLoading());
    await _subscription?.cancel();
    _subscription = _repository.frames.listen(
      (ObjectDetectionFrame frame) =>
          add(ObjectDetectionFrameReceived(frame)),
    );
    try {
      await _repository.start();
      emit(const ObjectDetectionReady(tick: 0, frame: null));
    } on CameraSessionException catch (e) {
      await _subscription?.cancel();
      _subscription = null;
      if (e.permissionDenied) {
        emit(ObjectDetectionPermissionDenied(e.message));
      } else {
        emit(ObjectDetectionFailure(e.message));
      }
    } on Object catch (e) {
      await _subscription?.cancel();
      _subscription = null;
      emit(ObjectDetectionFailure(e.toString()));
    }
  }

  void _onFrameReceived(
    ObjectDetectionFrameReceived event,
    Emitter<ObjectDetectionState> emit,
  ) {
    final ObjectDetectionState current = state;
    final int nextTick = switch (current) {
      ObjectDetectionReady(:final tick) => tick + 1,
      _ => 1,
    };
    emit(
      ObjectDetectionReady(
        tick: nextTick,
        frame: event.frame,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await _repository.dispose();
    return super.close();
  }
}
