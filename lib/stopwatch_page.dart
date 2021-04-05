import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/notification/notification_helper.dart';
import 'package:stopwatch/widget/stopwatch_joystick.dart';
import 'package:stopwatch/widget/stopwatch_laps_table.dart';
import 'package:stopwatch/widget/stopwatch_time_text.dart';

import 'bloc/stopwatch/stopwatch.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<StopwatchBloc, StopwatchState>(
      listener: (context, state) {
        print('BlocListener state $state');
        context.read<NotificationHelper>().showNotification(state.msec);
      },
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
}
