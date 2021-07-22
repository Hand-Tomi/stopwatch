import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch.dart';
import 'package:stopwatch/model/current_stopwatch.dart';
import 'package:stopwatch/repository/config_repository.dart';
import 'package:stopwatch/repository/history_repository.dart';
import 'package:stopwatch/util/replicator.dart';
import 'package:stopwatch/util/my_stopwatch.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final MyStopwatch _stopwatch;
  final Replicator _replcator;
  final HistoryRepository _historyRepository;
  final ConfigRepository _configRepository;

  StopwatchBloc({
    required MyStopwatch stopwatch,
    required Replicator replcator,
    required HistoryRepository historyRepository,
    required ConfigRepository configRepository,
  })  : _stopwatch = stopwatch,
        _replcator = replcator,
        _historyRepository = historyRepository,
        _configRepository = configRepository,
        super(StopwatchResetting());

  @override
  Stream<StopwatchState> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case StopwatchInitialize:
        yield* _mapStopwatchInitializeToState();
        break;
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

  Stream<StopwatchState> _mapStopwatchInitializeToState() async* {
    final currentStopwatch = await _configRepository.getCurrentStopwatch();
    if (currentStopwatch != null) {
      _stopwatch.init(currentStopwatch.start, currentStopwatch.stop);
      _historyRepository.currentKey = currentStopwatch.historyKey;
      yield StopwatchInitializing(_stopwatchMsec());
      if (!currentStopwatch.isStopped) {
        _replcator.start(_updateTime);
      }
    }
  }

  Stream<StopwatchState> _mapStopwatchStartedToState() async* {
    _renewCurrentHistoryIfNotExists();
    _stopwatch.start();
    _configRepository.putCurrentStopwatch(_createCurrentStopwatch());
    yield StopwatchPlaying(_stopwatchMsec());
    _replcator.start(_updateTime);
  }

  CurrentStopwatch _createCurrentStopwatch() {
    return CurrentStopwatch(
      start: _stopwatch.startElapsedMilliseconds,
      stop: _stopwatch.stopElapsedMilliseconds,
      historyKey: _historyRepository.currentKey,
    );
  }

  Stream<StopwatchState> _mapStopwatchTickedToState(
      StopwatchTicked event) async* {
    yield StopwatchPlaying(event.msec);
  }

  Stream<StopwatchState> _mapStopwatchPausedToState() async* {
    _replcator.stop();
    _stopwatch.stop();
    final currentMsec = _stopwatchMsec();
    _configRepository.putCurrentStopwatch(_createCurrentStopwatch());
    _saveHistoryIfCurrentHistoryExists(currentMsec);
    yield StopwatchPausing(currentMsec);
  }

  Stream<StopwatchState> _mapStopwatchResetToState() async* {
    _replcator.stop();
    _stopwatch.stop();
    await _saveHistoryIfCurrentHistoryExists(_stopwatchMsec());

    _stopwatch.reset();
    _configRepository.removeTimeStarted();
    _clearCurrentHistory();
    yield StopwatchResetting();
  }

  void _renewCurrentHistoryIfNotExists() {
    if (_historyRepository.isCurrentHistory()) {
      _historyRepository.openNewCurrentHistory();
    }
  }

  void _clearCurrentHistory() {
    _historyRepository.closeCurrentHistory();
  }

  Future<void> _saveHistoryIfCurrentHistoryExists(int msec) async {
    await _historyRepository.overwriteTimesInCurrentHistory(msec);
  }

  void _updateTime() {
    final msec = _stopwatchMsec();
    add(StopwatchTicked(msec));
  }

  int _stopwatchMsec() => _stopwatch.elapsedMilliseconds;
}
