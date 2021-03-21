import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch_event.dart';
import 'package:stopwatch/bloc/stopwatch_state.dart';
import 'package:stopwatch/replicator.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final Replicator _replcator;
  final Stopwatch _stopwatch;

  StopwatchBloc({@required Stopwatch stopwatch, @required Replicator replcator})
      : _stopwatch = stopwatch,
        _replcator = replcator,
        super(StopwatchInitial());

  @override
  Stream<StopwatchState> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case StopwatchStarted:
        yield* _mapStopwatchStartedToState();
        break;
      case StopwatchTicked:
        yield* _mapStopwatchTickedToState(event);
        break;
      case StopwatchPaused:
        yield* _mapStopwatchPausedToState();
        break;
      case StopwatchReset:
        yield* _mapStopwatchResetToState();
        break;
      default:
    }
  }

  Stream<StopwatchState> _mapStopwatchStartedToState() async* {
    _stopwatch.start();
    yield StopwatchPlaying(_stopwatchMsec());
    _replcator.start(_updateTime);
  }

  Stream<StopwatchState> _mapStopwatchTickedToState(
      StopwatchTicked event) async* {
    yield StopwatchPlaying(event.msec);
  }

  Stream<StopwatchState> _mapStopwatchPausedToState() async* {
    _replcator.stop();
    _stopwatch.stop();
    yield StopwatchPausing(_stopwatchMsec());
  }

  Stream<StopwatchState> _mapStopwatchResetToState() async* {
    _replcator.stop();
    _stopwatch.reset();
    yield StopwatchInitial();
  }

  void _updateTime() {
    final msec = _stopwatchMsec();
    add(StopwatchTicked(msec));
  }

  int _stopwatchMsec() => _stopwatch.elapsedMilliseconds;
}
