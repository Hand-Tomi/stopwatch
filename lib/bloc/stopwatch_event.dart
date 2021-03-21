import 'package:equatable/equatable.dart';

class StopwatchEvent extends Equatable {
  const StopwatchEvent();
  @override
  List<Object> get props => [];
}

class StopwatchStarted extends StopwatchEvent {}

class StopwatchTicked extends StopwatchEvent {
  final int msec;
  const StopwatchTicked(this.msec);
}

class StopwatchPaused extends StopwatchEvent {}

class StopwatchReset extends StopwatchEvent {}
