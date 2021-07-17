import 'package:equatable/equatable.dart';

abstract class StopwatchState extends Equatable {
  final int msec;

  const StopwatchState(this.msec);

  @override
  List<Object> get props => [msec];
}

class StopwatchInitializing extends StopwatchState {
  const StopwatchInitializing(int msec) : super(msec);
}

class StopwatchResetting extends StopwatchState {
  const StopwatchResetting() : super(0);
}

class StopwatchPlaying extends StopwatchState {
  const StopwatchPlaying(int msec) : super(msec);
}

class StopwatchPausing extends StopwatchState {
  const StopwatchPausing(int msec) : super(msec);
}
