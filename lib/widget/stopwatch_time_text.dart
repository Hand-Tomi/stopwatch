import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch.dart';
import 'package:stopwatch/util/msec_extensions.dart';

class StopwatchTimeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (conteseaxt, state) {
          return Text(
            state.msec.parseDisplayTime(),
            style: TextStyle(fontSize: 50.0),
          );
        },
      ),
    );
  }
}
