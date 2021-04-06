import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch_notification/stopwatch_notification_bloc.dart';
import 'package:stopwatch/widget/stopwatch_joystick.dart';
import 'package:stopwatch/widget/stopwatch_laps_table.dart';
import 'package:stopwatch/widget/stopwatch_time_text.dart';

import 'bloc/stopwatch/stopwatch.dart';
import 'bloc/stopwatch_notification/stopwatch_notification.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<StopwatchBloc, StopwatchState>(
      listener: _passingStateWithStopwatchNotification,
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
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

  void _passingStateWithStopwatchNotification(
      BuildContext context, StopwatchState state) {
    final stopwatchNotificationBloc = context.read<StopwatchNotificationBloc>();
    switch (state.runtimeType) {
      case StopwatchInitial:
        stopwatchNotificationBloc.add(StopwatchNotificationHided());
        break;
      default:
        stopwatchNotificationBloc.add(StopwatchNotificationShowed(state.msec));
    }
  }
}
