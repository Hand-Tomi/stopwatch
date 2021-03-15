import 'package:equatable/equatable.dart';

abstract class StopwatchState extends Equatable {
  final int msec;

  const StopwatchState(this.msec);

  @override
  List<Object> get props => [msec];
}

class StopwatchInitial extends StopwatchState {
  const StopwatchInitial() : super(0);
}

class StopwatchPlaying extends StopwatchState {
  const StopwatchPlaying(int msec) : super(msec);
}

class StopwatchPausing extends StopwatchState {
  const StopwatchPausing(int msec) : super(msec);
}
