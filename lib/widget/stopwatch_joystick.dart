import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch.dart';
import 'package:stopwatch/model/lap.dart';

class StopwatchJoystick extends StatelessWidget {
  static final iconSize = 80.0;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StopwatchBloc>(context);
    final lapsBloc = BlocProvider.of<LapsBloc>(context);
    return Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _leftButton(bloc, lapsBloc),
            _centerButton(bloc),
            _rightButton(lapsBloc),
          ],
        ));
  }

  Widget _leftButton(StopwatchBloc bloc, LapsBloc lapsBloc) {
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (context, state) {
          if (state is StopwatchInitial) {
            return _emptyWidget();
          } else {
            return _resetButton(bloc, lapsBloc);
          }
        },
      ),
    );
  }

  Widget _centerButton(StopwatchBloc bloc) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
        width: iconSize,
        height: iconSize,
        child: BlocBuilder<StopwatchBloc, StopwatchState>(
          builder: (context, state) {
            if (state is StopwatchPlaying) {
              return _pauseButton(bloc);
            } else {
              return _playButton(bloc);
            }
          },
        ),
      ),
    );
  }

  Widget _rightButton(LapsBloc bloc) {
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (context, state) {
          if (state is StopwatchPlaying) {
            return _splitButton(bloc, state);
          } else {
            return _emptyWidget();
          }
        },
      ),
    );
  }

  Widget _emptyWidget() => Container();

  Widget _playButton(StopwatchBloc bloc) {
    return IconButton(
        padding: const EdgeInsets.all(0.0),
        icon: Icon(
          Icons.play_circle_fill_rounded,
          size: iconSize,
        ),
        onPressed: () => bloc.add(StopwatchStarted()));
  }

  Widget _pauseButton(StopwatchBloc bloc) {
    return IconButton(
        padding: const EdgeInsets.all(0.0),
        icon: Icon(
          Icons.pause_circle_filled_rounded,
          size: iconSize,
        ),
        onPressed: () => bloc.add(StopwatchPaused()));
  }

  Widget _resetButton(StopwatchBloc bloc, LapsBloc lapsBloc) {
    return IconButton(
      padding: const EdgeInsets.all(0.0),
      icon: Icon(
        Icons.cancel,
        size: iconSize,
      ),
      onPressed: () {
        bloc.add(StopwatchReset());
        lapsBloc.add(LapsCleared());
      },
    );
  }

  Widget _splitButton(LapsBloc bloc, StopwatchState stopwatchState) {
    return IconButton(
      padding: const EdgeInsets.all(0.0),
      icon: Icon(
        Icons.add_circle,
        size: iconSize,
      ),
      onPressed: () {
        bloc.add(LapsAdded(_createLap(bloc, stopwatchState)));
      },
    );
  }

  Lap _createLap(LapsBloc lapsBloc, StopwatchState stopwatchState) {
    final lap = _countLap(lapsBloc);
    final laps = lapsBloc.state;
    final lastSplitTime = laps.isNotEmpty ? laps.last?.splitTime : 0;
    final lapTime = stopwatchState.msec - lastSplitTime;
    final splitTime = stopwatchState.msec;
    return Lap(lap, lapTime, splitTime);
  }

  static final _firstLapCount = 1;

  int _countLap(LapsBloc lapsBloc) {
    final lapCount = lapsBloc.state?.length ?? 0;
    return _firstLapCount + lapCount;
  }
}
