import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/model/lap.dart';
import 'package:stopwatch/repository/config_repository.dart';
import 'package:stopwatch/repository/history_repository.dart';

class LapsBloc extends Bloc<LapsEvent, List<Lap>> {
  final HistoryRepository _historyRepository;
  final ConfigRepository _configRepository;

  LapsBloc(this._historyRepository, this._configRepository) : super([]);

  @override
  Stream<List<Lap>> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case LapsInitialize:
        yield* _mapLapsInitializeToState();
        break;
      case LapsAdded:
        yield* _mapLapsAddedToState(event as LapsAdded);
        break;
      case LapsCleared:
        yield* _mapLapsClearedToState();
        break;
    }
  }

  Stream<List<Lap>> _mapLapsInitializeToState() async* {
    final currentStopwatch = await _configRepository.getCurrentStopwatch();
    if (currentStopwatch != null) {
      final history =
          await _historyRepository.getHistory(currentStopwatch.historyKey);
      if (history != null) {
        final laps = history.laps;
        if (laps != null) {
          yield laps;
        }
      }
    }
  }

  Stream<List<Lap>> _mapLapsAddedToState(LapsAdded event) async* {
    final List<Lap> updatedLaps = List.from(state)..add(event.lap);
    _saveLaps(updatedLaps);
    yield updatedLaps;
  }

  Stream<List<Lap>> _mapLapsClearedToState() async* {
    final List<Lap> updatedLaps = List.empty();
    yield updatedLaps;
  }

  Future<void> _saveLaps(List<Lap> laps) async {
    _historyRepository.overwriteLapsInCurrentHistory(laps);
  }
}
