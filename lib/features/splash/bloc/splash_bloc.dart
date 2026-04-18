import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({Duration delay = const Duration(milliseconds: 900)})
      : _delay = delay,
        super(const SplashInitial()) {
    on<SplashStarted>(_onStarted);
  }

  final Duration _delay;

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    await Future<void>.delayed(_delay);
    emit(const SplashCompleted());
  }
}
