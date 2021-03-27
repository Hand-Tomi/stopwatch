import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_bloc.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_event.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch_state.dart';
import 'package:stopwatch/replicator.dart';

class MockStopwatch extends Mock implements Stopwatch {}

class MockReplcator extends Mock implements Replicator {}

void main() {
  StopwatchBloc bloc;
  MockStopwatch mockStopwatch;
  MockReplcator mockReplcator;

  setUp(() {
    mockStopwatch = MockStopwatch();
    mockReplcator = MockReplcator();
    bloc = StopwatchBloc(
      stopwatch: mockStopwatch,
      replcator: mockReplcator,
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
        verify(mockReplcator.start(any));
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
        verify(mockReplcator.stop());
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
        verify(mockReplcator.stop());
      },
    );
  });
}
