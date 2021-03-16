import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch_event.dart';
import 'package:stopwatch/bloc/stopwatch_state.dart';
import 'package:stopwatch/bloc/stopwatch_bloc.dart';

class StopwatchJoystick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: _centerButton(BlocProvider.of<StopwatchBloc>(context)));
  }

  Widget _centerButton(StopwatchBloc bloc) {
    return SizedBox(
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
    );
  }

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
}
