import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch.dart';
import 'package:stopwatch/util/msec_extensions.dart';

class StopwatchTimeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
      child: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (context, state) {
          return Text(
            state.msec.parseDisplayTime(),
            style: Theme.of(context).textTheme.headline1,
          );
        },
      ),
    );
  }
}
