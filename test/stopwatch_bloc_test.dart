import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_bloc.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_event.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_state.dart';
import 'package:stopwatch/util/replicator.dart';
import 'package:mockito/annotations.dart';

import 'stopwatch_bloc_test.mocks.dart';

@GenerateMocks([Stopwatch, Replicator])
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
