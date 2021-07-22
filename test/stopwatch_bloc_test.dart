import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_bloc.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_event.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_state.dart';
import 'package:stopwatch/model/current_stopwatch.dart';
import 'package:stopwatch/repository/config_repository.dart';
import 'package:stopwatch/repository/history_repository.dart';
import 'package:stopwatch/util/my_stopwatch.dart';
import 'package:stopwatch/util/replicator.dart';
import 'package:mockito/annotations.dart';

import 'stopwatch_bloc_test.mocks.dart';

@GenerateMocks([MyStopwatch, Replicator, HistoryRepository, ConfigRepository])
void main() {
  late StopwatchBloc bloc;
  late MockMyStopwatch mockStopwatch;
  late MockReplicator mockReplicator;
  late MockHistoryRepository mockHistoryRepository;
  late MockConfigRepository mockConfigRepository;
  final dummyStart = 123;
  final dummyStop = 124;
  final dummyHistoryKey = "historyKey";
  final dummyCurrentStopwath = CurrentStopwatch(
    start: dummyStart,
    stop: dummyStop,
    historyKey: dummyHistoryKey,
  );

  setUp(() {
    mockStopwatch = MockMyStopwatch();
    mockReplicator = MockReplicator();
    mockHistoryRepository = MockHistoryRepository();
    mockConfigRepository = MockConfigRepository();
    int dummySecond = 0;
    when(mockStopwatch.elapsedMilliseconds).thenAnswer((realInvocation) {
      return dummySecond++;
    });
    when(mockStopwatch.startElapsedMilliseconds).thenReturn(dummyStart);
    when(mockStopwatch.stopElapsedMilliseconds).thenReturn(dummyStop);
    when(mockHistoryRepository.currentKey).thenReturn(dummyHistoryKey);
    bloc = StopwatchBloc(
      stopwatch: mockStopwatch,
      replcator: mockReplicator,
      historyRepository: mockHistoryRepository,
      configRepository: mockConfigRepository,
    );
  });

  group('StopwatchBloc', () {
    blocTest<StopwatchBloc, StopwatchState>(
      'started -> ticked -> paused',
      build: () {
        when(mockHistoryRepository.isCurrentHistory()).thenReturn(true);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchTicked(1));
        bloc.add(StopwatchPaused());
      },
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[
        StopwatchPlaying(0),
        StopwatchPlaying(1),
        StopwatchPausing(1),
      ],
      verify: (_) {
        verifyInOrder([
          mockHistoryRepository.openNewCurrentHistory(),
          mockHistoryRepository.overwriteTimesInCurrentHistory(1),
        ]);
        verifyInOrder([
          mockStopwatch.start(),
          mockStopwatch.stop(),
        ]);
        verifyInOrder([
          mockReplicator.start(any),
          mockReplicator.stop(),
        ]);
        verify(mockConfigRepository.putCurrentStopwatch(dummyCurrentStopwath));
      },
    );

    blocTest<StopwatchBloc, StopwatchState>(
      'started -> ticked -> reset',
      build: () {
        when(mockHistoryRepository.isCurrentHistory()).thenReturn(true);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchTicked(1));
        bloc.add(StopwatchReset());
      },
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[
        StopwatchPlaying(0),
        StopwatchPlaying(1),
        StopwatchResetting(),
      ],
      verify: (_) {
        verifyInOrder([
          mockHistoryRepository.openNewCurrentHistory(),
          mockHistoryRepository.overwriteTimesInCurrentHistory(1),
          mockHistoryRepository.closeCurrentHistory(),
        ]);
        verifyInOrder([
          mockStopwatch.start(),
          mockStopwatch.stop(),
        ]);
        verifyInOrder([
          mockReplicator.start(any),
          mockReplicator.stop(),
        ]);
        verifyInOrder([
          mockConfigRepository.putCurrentStopwatch(dummyCurrentStopwath),
          mockConfigRepository.removeTimeStarted(),
        ]);
      },
    );

    blocTest<StopwatchBloc, StopwatchState>(
      'started -> ticked -> paused -> reset',
      build: () {
        when(mockHistoryRepository.isCurrentHistory()).thenReturn(true);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchTicked(1));
        bloc.add(StopwatchPaused());
        bloc.add(StopwatchReset());
      },
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[
        StopwatchPlaying(0),
        StopwatchPlaying(1),
        StopwatchPausing(1),
        StopwatchResetting(),
      ],
      verify: (_) {
        verifyInOrder([
          mockHistoryRepository.openNewCurrentHistory(),
          mockHistoryRepository.overwriteTimesInCurrentHistory(1),
          mockHistoryRepository.overwriteTimesInCurrentHistory(2),
          mockHistoryRepository.closeCurrentHistory(),
        ]);
        verifyInOrder([
          mockStopwatch.start(),
          mockStopwatch.stop(),
        ]);
        verifyInOrder([
          mockReplicator.start(any),
          mockReplicator.stop(),
        ]);
        verifyInOrder([
          mockConfigRepository.putCurrentStopwatch(dummyCurrentStopwath),
          mockConfigRepository.removeTimeStarted(),
        ]);
      },
    );

    blocTest<StopwatchBloc, StopwatchState>(
      'started -> ticked -> paused -> started -> ticked -> reset',
      build: () {
        when(mockHistoryRepository.isCurrentHistory()).thenReturn(true);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchTicked(1));
        bloc.add(StopwatchPaused());
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchTicked(2));
        bloc.add(StopwatchReset());
      },
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[
        StopwatchPlaying(0),
        StopwatchPlaying(1),
        StopwatchPausing(1),
        StopwatchPlaying(2),
        StopwatchResetting(),
      ],
      verify: (_) {
        verifyInOrder([
          mockHistoryRepository.openNewCurrentHistory(),
          mockHistoryRepository.overwriteTimesInCurrentHistory(1),
          mockHistoryRepository.openNewCurrentHistory(),
          mockHistoryRepository.overwriteTimesInCurrentHistory(3),
          mockHistoryRepository.closeCurrentHistory(),
        ]);
        verifyInOrder([
          mockStopwatch.start(),
          mockStopwatch.stop(),
          mockStopwatch.start(),
          mockStopwatch.stop(),
          mockStopwatch.reset(),
        ]);
        verifyInOrder([
          mockReplicator.start(any),
          mockReplicator.stop(),
          mockReplicator.start(any),
          mockReplicator.stop(),
        ]);
        verifyInOrder([
          mockConfigRepository.putCurrentStopwatch(dummyCurrentStopwath),
          mockConfigRepository.putCurrentStopwatch(dummyCurrentStopwath),
          mockConfigRepository.removeTimeStarted(),
        ]);
      },
    );

    blocTest<StopwatchBloc, StopwatchState>(
      'started -> ticked -> paused -> started -> ticked -> paused -> reset',
      build: () {
        when(mockHistoryRepository.isCurrentHistory()).thenReturn(true);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchTicked(1));
        bloc.add(StopwatchPaused());
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchTicked(2));
        bloc.add(StopwatchPaused());
        bloc.add(StopwatchReset());
      },
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[
        StopwatchPlaying(0),
        StopwatchPlaying(1),
        StopwatchPausing(1),
        StopwatchPlaying(2),
        StopwatchPausing(3),
        StopwatchResetting(),
      ],
      verify: (_) {
        verifyInOrder([
          mockHistoryRepository.openNewCurrentHistory(),
          mockHistoryRepository.overwriteTimesInCurrentHistory(1),
          mockHistoryRepository.openNewCurrentHistory(),
          mockHistoryRepository.overwriteTimesInCurrentHistory(3),
          mockHistoryRepository.overwriteTimesInCurrentHistory(4),
          mockHistoryRepository.closeCurrentHistory(),
        ]);
        verifyInOrder([
          mockStopwatch.start(),
          mockStopwatch.stop(),
          mockStopwatch.start(),
          mockStopwatch.stop(),
          mockStopwatch.stop(),
          mockStopwatch.reset(),
        ]);
        verifyInOrder([
          mockReplicator.start(any),
          mockReplicator.stop(),
          mockReplicator.start(any),
          mockReplicator.stop(),
          mockReplicator.stop(),
        ]);
        verifyInOrder([
          mockConfigRepository.putCurrentStopwatch(dummyCurrentStopwath),
          mockConfigRepository.putCurrentStopwatch(dummyCurrentStopwath),
          mockConfigRepository.removeTimeStarted(),
        ]);
      },
    );
  });
}
