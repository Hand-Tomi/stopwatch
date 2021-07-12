import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/bloc/stopwatch_notification/stopwatch_notification_bloc.dart';
import 'package:stopwatch/page/switch/drawer_list.dart';
import 'package:stopwatch/page/switch/widget/stopwatch_joystick.dart';
import 'package:stopwatch/page/switch/widget/stopwatch_time_text.dart';
import 'package:stopwatch/page/widget/laps_table.dart';

import '../../bloc/stopwatch/stopwatch.dart';
import '../../bloc/stopwatch_notification/stopwatch_notification.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  static final pageTitle = 'Stopwatch';

  @override
  Widget build(BuildContext context) {
    final streamLaps = context.read<LapsBloc>().stream;
    return BlocListener<StopwatchBloc, StopwatchState>(
      listener: _passingStateWithStopwatchNotification,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        drawer: Drawer(
          child: DrawerList(),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StopwatchTimeText(),
                LapsTable(streamLaps),
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
      case StopwatchResetting:
        stopwatchNotificationBloc.add(StopwatchNotificationHided());
        break;
      default:
        stopwatchNotificationBloc.add(StopwatchNotificationShowed(state.msec));
    }
  }
}
