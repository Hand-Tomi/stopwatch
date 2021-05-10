import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_bloc.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_event.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_state.dart';
import 'package:stopwatch/model/history.dart';
import 'package:stopwatch/repository/history_repository.dart';
import 'package:stopwatch/util/replicator.dart';
import 'package:mockito/annotations.dart';

import 'stopwatch_bloc_test.mocks.dart';

@GenerateMocks([Stopwatch, Replicator, HistoryRepository])
void main() {
  late StopwatchBloc bloc;
  late MockStopwatch mockStopwatch;
  late MockReplicator mockReplicator;
  late MockHistoryRepository mockHistoryRepository;
  String _dummyHistoryKey = "dummyHistoryKey";

  setUp(() {
    mockStopwatch = MockStopwatch();
    mockReplicator = MockReplicator();
    mockHistoryRepository = MockHistoryRepository();
    when(mockHistoryRepository.createNextKey()).thenReturn(_dummyHistoryKey);
    when(mockStopwatch.elapsedMilliseconds).thenReturn(0);
    bloc = StopwatchBloc(
      stopwatch: mockStopwatch,
      replcator: mockReplicator,
      historyRepository: mockHistoryRepository,
    );
  });

  group('StopwatchBloc', () {
    blocTest<StopwatchBloc, StopwatchState>(
      'started',
      build: () => bloc,
      act: (bloc) => bloc.add(StopwatchStarted()),
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[StopwatchPlaying(0)],
      verify: (_) {
        verify(mockStopwatch.start());
        verify(mockReplicator.start(any));
      },
    );

    blocTest<StopwatchBloc, StopwatchState>(
      'paused',
      build: () => bloc,
      act: (bloc) => bloc.add(StopwatchPaused()),
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[StopwatchPausing(0)],
      verify: (_) {
        verify(mockStopwatch.stop());
        verify(mockReplicator.stop());
      },
    );

    blocTest<StopwatchBloc, StopwatchState>(
      'ticked',
      build: () => bloc,
      act: (bloc) => bloc.add(StopwatchTicked(10)),
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[StopwatchPlaying(10)],
    );

    blocTest<StopwatchBloc, StopwatchState>(
      'reset',
      build: () => bloc,
      act: (bloc) => bloc.add(StopwatchReset()),
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[StopwatchInitial()],
      verify: (_) {
        verify(mockStopwatch.reset());
        verify(mockReplicator.stop());
      },
    );

    final dummyDateTime = DateTime.now();

    blocTest<StopwatchBloc, StopwatchState>(
      'History 저장 테스트 starte -> ticked -> paused -> reset',
      build: () {
        when(mockHistoryRepository.createHistory(any))
            .thenAnswer((realInvocation) {
          final msec = realInvocation.positionalArguments[0] as int;
          return History(msec, dummyDateTime);
        });
        return bloc;
      },
      act: (bloc) {
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchTicked(10));
        bloc.add(StopwatchPaused());
        bloc.add(StopwatchReset());
      },
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[
        StopwatchPlaying(0),
        StopwatchPlaying(10),
        StopwatchPausing(0),
        StopwatchInitial(),
      ],
      verify: (_) {
        verifyInOrder(
          [
            mockHistoryRepository.createNextKey(),
            mockHistoryRepository.saveHistory(
              argThat(contains(_dummyHistoryKey)),
              argThat(predicate<History>((history) {
                return history.isSame(History(0, dummyDateTime));
              })),
            ),
          ],
        );
      },
    );

    blocTest<StopwatchBloc, StopwatchState>(
      'History 저장 테스트 starte -> ticked -> reset',
      build: () {
        when(mockHistoryRepository.createHistory(any))
            .thenAnswer((realInvocation) {
          final msec = realInvocation.positionalArguments[0] as int;
          return History(msec, dummyDateTime);
        });
        return bloc;
      },
      act: (bloc) {
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchTicked(10));
        bloc.add(StopwatchReset());
      },
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[
        StopwatchPlaying(0),
        StopwatchPlaying(10),
        StopwatchInitial(),
      ],
      verify: (_) {
        verifyInOrder(
          [
            mockHistoryRepository.createNextKey(),
            mockHistoryRepository.saveHistory(
              argThat(contains(_dummyHistoryKey)),
              argThat(predicate<History>((history) {
                return history.isSame(History(0, dummyDateTime));
              })),
            ),
          ],
        );
      },
    );
  });
}
