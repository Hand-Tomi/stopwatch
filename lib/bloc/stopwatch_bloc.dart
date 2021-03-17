import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch_event.dart';
import 'package:stopwatch/bloc/stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final Stopwatch _stopwatch;
  Timer _updater;

  StopwatchBloc({@required Stopwatch stopwatch})
      : _stopwatch = stopwatch,
        super(StopwatchInitial());

  @override
  Stream<StopwatchState> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case StopwatchStarted:
        yield* _mapStopwatchStartedToState();
        break;
      case StopwatchTicked:
        yield* _mapStopwatchTickedToState();
        break;
      case StopwatchPaused:
        yield* _mapStopwatchPausedToState();
        break;
      default:
    }
  }

  Stream<StopwatchState> _mapStopwatchStartedToState() async* {
    _stopwatch.start();
    yield StopwatchPlaying(_stopwatchMsec());
    _updater = Timer.periodic(const Duration(milliseconds: 10), _updateTime);
  }

  Stream<StopwatchState> _mapStopwatchTickedToState() async* {
    yield StopwatchPlaying(_stopwatchMsec());
  }

  Stream<StopwatchState> _mapStopwatchPausedToState() async* {
    _updater.cancel();
    _updater = null;
    _stopwatch.stop();
    yield StopwatchPausing(_stopwatchMsec());
  }

  void _updateTime(Timer _) {
    add(StopwatchTicked(_stopwatchMsec()));
  }

  int _stopwatchMsec() => _stopwatch.elapsedMilliseconds;
}
