import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_ml_kit_test_app/features/example/data/repositories/post_repository.dart';
import 'package:google_ml_kit_test_app/features/example/model/post.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc({required PostRepository repository})
      : _repository = repository,
        super(const ExampleInitial()) {
    on<ExampleLoadRequested>(_onLoadRequested);
  }

  final PostRepository _repository;

  Future<void> _onLoadRequested(
    ExampleLoadRequested event,
    Emitter<ExampleState> emit,
  ) async {
    emit(const ExampleLoadInProgress());
    try {
      final Post post = await _repository.getPostById(1);
      emit(ExampleLoadSuccess(post));
    } on Object catch (e) {
      emit(ExampleLoadFailure(e.toString()));
    }
  }
}
