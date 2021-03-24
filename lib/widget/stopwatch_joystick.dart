import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch.dart';
import 'package:stopwatch/model/lap.dart';

class StopwatchJoystick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StopwatchBloc>(context);
    final lapsBloc = BlocProvider.of<LapsBloc>(context);
    return Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _leftButton(bloc),
            _centerButton(bloc),
            _rightButton(lapsBloc),
          ],
        ));
  }

  Widget _leftButton(StopwatchBloc bloc) {
    return SizedBox(
      width: 60.0,
      height: 60.0,
      child: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (context, state) {
          if (state is StopwatchInitial) {
            return _emptyWidget();
          } else {
            return _resetButton(bloc);
          }
        },
      ),
    );
  }

  Widget _centerButton(StopwatchBloc bloc) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
        width: 60.0,
        height: 60.0,
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
      width: 60.0,
      height: 60.0,
      child: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (context, state) {
          return _splitButton(bloc, state);
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
          size: 60.0,
        ),
        onPressed: () => bloc.add(StopwatchStarted()));
  }

  Widget _pauseButton(StopwatchBloc bloc) {
    return IconButton(
        padding: const EdgeInsets.all(0.0),
        icon: Icon(
          Icons.pause_circle_filled_rounded,
          size: 60.0,
        ),
        onPressed: () => bloc.add(StopwatchPaused()));
  }

  Widget _resetButton(StopwatchBloc bloc) {
    return IconButton(
      padding: const EdgeInsets.all(0.0),
      icon: Icon(
        Icons.cancel,
        size: 60.0,
      ),
      onPressed: () => bloc.add(StopwatchReset()),
    );
  }

  Widget _splitButton(LapsBloc bloc, StopwatchState stopwatchState) {
    return IconButton(
      padding: const EdgeInsets.all(0.0),
      icon: Icon(
        Icons.add_circle,
        size: 60.0,
      ),
      onPressed: () {
        bloc.add(LapsAdded(createLap(bloc, stopwatchState)));
      },
    );
  }

  Lap createLap(LapsBloc lapsBloc, StopwatchState stopwatchState) {
    final lap = lapsBloc.state?.length ?? 0;
    final lapTime = stopwatchState.msec;
    final splitTime = stopwatchState.msec;
    return Lap(lap, lapTime, splitTime);
  }
}
