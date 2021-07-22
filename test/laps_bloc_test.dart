import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/model/current_stopwatch.dart';
import 'package:stopwatch/model/history.dart';
import 'package:stopwatch/model/lap.dart';
import 'package:mockito/annotations.dart';
import 'package:stopwatch/repository/config_repository.dart';
import 'package:stopwatch/repository/history_repository.dart';

import 'laps_bloc_test.mocks.dart';

@GenerateMocks([HistoryRepository, ConfigRepository])
void main() {
  late LapsBloc lapsBloc;
  late MockHistoryRepository mockHistoryRepository;
  late MockConfigRepository mockConfigRepository;

  setUp(() {
    mockHistoryRepository = MockHistoryRepository();
    mockConfigRepository = MockConfigRepository();
    lapsBloc = LapsBloc(mockHistoryRepository, mockConfigRepository);
  });

  void setupHistory(List<Lap>? laps) {
    final dummyHistoryKey = "dummyHistoryKey";
    final currentStopwatch = CurrentStopwatch(
      start: 1,
      stop: 2,
      historyKey: dummyHistoryKey,
    );
    when(mockConfigRepository.getCurrentStopwatch())
        .thenAnswer((_) => Future.value(currentStopwatch));

    final dummyHistory = History(0, DateTime.now(), laps: laps);
    when(mockHistoryRepository.getHistory(dummyHistoryKey))
        .thenAnswer((_) => Future.value(dummyHistory));
  }

  group('LapsBloc', () {
    blocTest<LapsBloc, List<Lap>>(
      'init -> add',
      build: () {
        setupHistory([Lap(0, 0, 0)]);
        return lapsBloc;
      },
      act: (bloc) {
        bloc.add(LapsInitialize());
        bloc.add(LapsAdded(Lap(1, 1, 1)));
        bloc.add(LapsAdded(Lap(2, 2, 2)));
        bloc.add(LapsAdded(Lap(3, 3, 3)));
      },
      expect: () => <List<Lap>>[
        [Lap(0, 0, 0)],
        [Lap(0, 0, 0), Lap(1, 1, 1)],
        [Lap(0, 0, 0), Lap(1, 1, 1), Lap(2, 2, 2)],
        [Lap(0, 0, 0), Lap(1, 1, 1), Lap(2, 2, 2), Lap(3, 3, 3)],
      ],
    );
    blocTest<LapsBloc, List<Lap>>(
      'init -> add -> clear',
      build: () {
        setupHistory(null);
        return lapsBloc;
      },
      act: (bloc) {
        bloc.add(LapsAdded(Lap(1, 1, 1)));
        bloc.add(LapsAdded(Lap(2, 2, 2)));
        bloc.add(LapsAdded(Lap(3, 3, 3)));
        bloc.add(LapsCleared());
      },
      expect: () => <List<Lap>>[
        [Lap(1, 1, 1)],
        [Lap(1, 1, 1), Lap(2, 2, 2)],
        [Lap(1, 1, 1), Lap(2, 2, 2), Lap(3, 3, 3)],
        [],
      ],
    );
  });
}
