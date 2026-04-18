part of 'example_bloc.dart';

sealed class ExampleState extends Equatable {
  const ExampleState();

  @override
  List<Object?> get props => [];
}

final class ExampleInitial extends ExampleState {
  const ExampleInitial();
}

final class ExampleLoadInProgress extends ExampleState {
  const ExampleLoadInProgress();
}

final class ExampleLoadSuccess extends ExampleState {
  const ExampleLoadSuccess(this.post);

  final Post post;

  @override
  List<Object?> get props => [post];
}

final class ExampleLoadFailure extends ExampleState {
  const ExampleLoadFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
