import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch.dart';
import 'package:stopwatch/repository/history_repository.dart';
import 'package:stopwatch/util/replicator.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final Stopwatch _stopwatch;
  final Replicator _replcator;
  final HistoryRepository _historyRepository;

  StopwatchBloc(
      {required Stopwatch stopwatch,
      required Replicator replcator,
      required HistoryRepository historyRepository})
      : _stopwatch = stopwatch,
        _replcator = replcator,
        _historyRepository = historyRepository,
        super(StopwatchInitial());

  @override
  Stream<StopwatchState> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case StopwatchStarted:
        yield* _mapStopwatchStartedToState();
        break;
      case StopwatchTicked:
        yield* _mapStopwatchTickedToState(event as StopwatchTicked);
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
    renewCurrentHistoryIfNotExists();
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
    final currentMsec = _stopwatchMsec();
    saveHistoryIfCurrentHistoryExists(currentMsec);
    yield StopwatchPausing(currentMsec);
  }

  Stream<StopwatchState> _mapStopwatchResetToState() async* {
    _replcator.stop();
    _stopwatch.stop();
    await saveHistoryIfCurrentHistoryExists(_stopwatchMsec());

    _stopwatch.reset();
    clearHistoryKey();
    yield StopwatchInitial();
  }

  void _updateTime() {
    final msec = _stopwatchMsec();
    add(StopwatchTicked(msec));
  }

  int _stopwatchMsec() => _stopwatch.elapsedMilliseconds;

  void renewCurrentHistoryIfNotExists() {
    if (_historyRepository.isCurrentHistory()) {
      _historyRepository.renewCurrentHistory();
    }
  }

  void clearHistoryKey() {
    _historyRepository.clearCurrentHistory();
  }

  Future<void> saveHistoryIfCurrentHistoryExists(int msec) async {
    await _historyRepository.overwriteTimesInCurrentHistory(msec);
  }
}
