import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch_bloc.dart';
import 'package:stopwatch/bloc/stopwatch_state.dart';

class StopwatchTimeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (conteseaxt, state) {
          return Text(
            _getDisplayTime(state.msec),
            style: TextStyle(fontSize: 50.0),
          );
        },
      ),
    );
  }

  String _getDisplayTime(int msec) {
    final minute = (msec / (60 * 1000)).floor().toString().padLeft(2, '0');
    final second =
        (msec % (60 * 1000) / 1000).floor().toString().padLeft(2, '0');
    final milliSecond = (msec % 1000 / 10).floor().toString().padLeft(2, '0');

    return '$minute:$second:$milliSecond';
  }
}
