import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/model/lap.dart';
import 'package:mockito/annotations.dart';
import 'package:stopwatch/repository/history_repository.dart';

import 'laps_bloc_test.mocks.dart';

@GenerateMocks([HistoryRepository])
void main() {
  late LapsBloc lapsBloc;
  late MockHistoryRepository mockHistoryRepository;

  setUp(() {
    mockHistoryRepository = MockHistoryRepository();
    lapsBloc = LapsBloc(mockHistoryRepository);
  });

  group('LapsBloc', () {
    blocTest<LapsBloc, List<Lap>>(
      'add',
      build: () => lapsBloc,
      act: (bloc) {
        bloc.add(LapsAdded(Lap(1, 1, 1)));
        bloc.add(LapsAdded(Lap(2, 2, 2)));
        bloc.add(LapsAdded(Lap(3, 3, 3)));
      },
      expect: () => <List<Lap>>[
        [Lap(1, 1, 1)],
        [Lap(1, 1, 1), Lap(2, 2, 2)],
        [Lap(1, 1, 1), Lap(2, 2, 2), Lap(3, 3, 3)],
      ],
    );
    blocTest<LapsBloc, List<Lap>>(
      'clear',
      build: () => lapsBloc,
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
