import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_bloc.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_event.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_state.dart';
import 'package:stopwatch/replicator.dart';
import 'package:mockito/annotations.dart';

import 'stopwatch_bloc_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    // https://github.com/dart-lang/mockito/issues/367
    // 현재 "void function"는 제대로 Mock가 되지 않는 문제점이 발생하고 있다.
    // 위의 Issue가 해결 될때까지는 아래와 같이 레거시를 사용한다.
    MockSpec<Stopwatch>(returnNullOnMissingStub: true),
    MockSpec<Replicator>(returnNullOnMissingStub: true)
  ],
)
void main() {
  late StopwatchBloc bloc;
  late MockStopwatch mockStopwatch;
  late MockReplicator mockReplicator;

  setUp(() {
    mockStopwatch = MockStopwatch();
    mockReplicator = MockReplicator();
    bloc = StopwatchBloc(
      stopwatch: mockStopwatch,
      replcator: mockReplicator,
    );
  });

  group('StopwatchBloc', () {
    blocTest<StopwatchBloc, StopwatchState>(
      'started',
      build: () {
        when(mockStopwatch.elapsedMilliseconds).thenReturn(0);
        return bloc;
      },
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
      build: () {
        when(mockStopwatch.elapsedMilliseconds).thenReturn(0);
        return bloc;
      },
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
  });
}
