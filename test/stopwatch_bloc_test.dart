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
  final _baseDummyHistoryKeys = ['first key', 'second key', 'thirdly'];

  setUp(() {
    mockStopwatch = MockStopwatch();
    mockReplicator = MockReplicator();
    mockHistoryRepository = MockHistoryRepository();
    final _dummyHistoryKeys = [..._baseDummyHistoryKeys];
    when(mockHistoryRepository.createNextKey())
        .thenAnswer((_) => _dummyHistoryKeys.removeAt(0));
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
            mockHistoryRepository.putHistory(
              argThat(contains(_baseDummyHistoryKeys[0])),
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
            mockHistoryRepository.putHistory(
              argThat(contains(_baseDummyHistoryKeys[0])),
              argThat(predicate<History>((history) {
                return history.isSame(History(0, dummyDateTime));
              })),
            ),
          ],
        );
      },
    );

    blocTest<StopwatchBloc, StopwatchState>(
      'History 저장 테스트 started -> ticked -> paused -> started -> reset',
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
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchReset());
      },
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[
        StopwatchPlaying(0),
        StopwatchPlaying(10),
        StopwatchPausing(0),
        StopwatchPlaying(0),
        StopwatchInitial(),
      ],
      verify: (_) {
        // reset후에 다시 started하지 않으면 새로운 키(historyKey)로 저장하지 않는다.
        verifyNever(
          mockHistoryRepository.putHistory(
            argThat(contains(_baseDummyHistoryKeys[1])),
            argThat(predicate<History>((history) {
              return history.isSame(History(0, dummyDateTime));
            })),
          ),
        );
        verifyInOrder(
          [
            mockHistoryRepository.createNextKey(),
            mockHistoryRepository.putHistory(
              argThat(contains(_baseDummyHistoryKeys[0])),
              argThat(predicate<History>((history) {
                return history.isSame(History(0, dummyDateTime));
              })),
            ),
          ],
        );
      },
    );

    blocTest<StopwatchBloc, StopwatchState>(
      'History 2개 저장 테스트 started -> paused -> reset -> started -> paused',
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
        bloc.add(StopwatchPaused());
        bloc.add(StopwatchReset());
        bloc.add(StopwatchStarted());
        bloc.add(StopwatchPaused());
      },
      wait: Duration(milliseconds: 50),
      expect: () => const <StopwatchState>[
        StopwatchPlaying(0),
        StopwatchPausing(0),
        StopwatchInitial(),
        StopwatchPlaying(0),
        StopwatchPausing(0),
      ],
      verify: (_) {
        verifyInOrder(
          [
            mockHistoryRepository.createNextKey(),
            mockHistoryRepository.putHistory(
              argThat(contains(_baseDummyHistoryKeys[0])),
              argThat(predicate<History>((history) {
                return history.isSame(History(0, dummyDateTime));
              })),
            ),
            mockHistoryRepository.createNextKey(),
            mockHistoryRepository.putHistory(
              argThat(contains(_baseDummyHistoryKeys[1])),
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
