import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/model/lap.dart';

class LapsBloc extends Bloc<LapsEvent, List<Lap>> {
  LapsBloc() : super([]);

  @override
  Stream<List<Lap>> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case LapsAdded:
        yield* _mapLapsAddedToState(event);
        break;
      case LapsCleared:
        yield* _mapLapsClearedToState();
        break;
    }
  }

  Stream<List<Lap>> _mapLapsAddedToState(LapsAdded event) async* {
    final List<Lap> updatedLaps = List.from(state)..add(event.lap);
    yield updatedLaps;
  }

  Stream<List<Lap>> _mapLapsClearedToState() async* {
    yield List.empty();
  }
}
