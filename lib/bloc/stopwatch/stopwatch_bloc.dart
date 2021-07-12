import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch.dart';
import 'package:stopwatch/repository/history_repository.dart';
import 'package:stopwatch/util/replicator.dart';
import 'package:stopwatch/util/my_stopwatch.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final MyStopwatch _stopwatch;
  final Replicator _replcator;
  final HistoryRepository _historyRepository;

  StopwatchBloc(
      {required MyStopwatch stopwatch,
      required Replicator replcator,
      required HistoryRepository historyRepository})
      : _stopwatch = stopwatch,
        _replcator = replcator,
        _historyRepository = historyRepository,
        super(StopwatchResetting());

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
    _renewCurrentHistoryIfNotExists();
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
    _saveHistoryIfCurrentHistoryExists(currentMsec);
    yield StopwatchPausing(currentMsec);
  }

  Stream<StopwatchState> _mapStopwatchResetToState() async* {
    _replcator.stop();
    _stopwatch.stop();
    await _saveHistoryIfCurrentHistoryExists(_stopwatchMsec());

    _stopwatch.reset();
    _clearCurrentHistory();
    yield StopwatchResetting();
  }

  void _renewCurrentHistoryIfNotExists() {
    if (_historyRepository.isCurrentHistory()) {
      _historyRepository.renewCurrentHistory();
    }
  }

  void _clearCurrentHistory() {
    _historyRepository.clearCurrentHistory();
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
