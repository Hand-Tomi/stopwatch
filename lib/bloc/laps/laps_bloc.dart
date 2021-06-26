import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/model/lap.dart';
import 'package:stopwatch/repository/history_repository.dart';

class LapsBloc extends Bloc<LapsEvent, List<Lap>> {
  final HistoryRepository _historyRepository;

  LapsBloc(this._historyRepository) : super([]);

  @override
  Stream<List<Lap>> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case LapsAdded:
        yield* _mapLapsAddedToState(event as LapsAdded);
        break;
      case LapsCleared:
        yield* _mapLapsClearedToState();
        break;
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
