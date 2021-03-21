import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/replicator.dart';
import 'package:stopwatch/widget/stopwatch_joystick.dart';
import 'package:stopwatch/widget/stopwatch_laps_table.dart';
import 'package:stopwatch/widget/stopwatch_time_text.dart';

import 'bloc/stopwatch/stopwatch_bloc.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  static final Duration _updateInterval = Duration(milliseconds: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: BlocProvider<StopwatchBloc>(
            create: (context) => StopwatchBloc(
              stopwatch: Stopwatch(),
              replcator: Replicator(_updateInterval),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StopwatchTimeText(),
                StopwatchLapsTable(),
                StopwatchJoystick(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
