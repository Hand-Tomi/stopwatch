import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/bloc/stopwatch/stopwatch.dart';
import 'package:stopwatch/bloc/stopwatch_notification/stopwatch_notification.dart';
import 'package:stopwatch/notification/notification_helper.dart';
import 'package:stopwatch/util/replicator.dart';
import 'package:stopwatch/util/my_stopwatch.dart';
import 'package:stopwatch/page/switch/stopwatch_page.dart';

class StopwatchPageCreator {
  Widget create(BuildContext context) {
    return MultiBlocProvider(
      providers: stopwatchPageBlocProvider(),
      child: StopwatchPage(),
    );
  }

  List<BlocProvider> stopwatchPageBlocProvider() {
    final Duration _updateInterval = const Duration(milliseconds: 10);
    return [
      BlocProvider<StopwatchBloc>(
        create: (context) => StopwatchBloc(
          stopwatch: MyStopwatch(),
          replcator: Replicator(_updateInterval),
          historyRepository: context.read(),
        ),
      ),
      BlocProvider<LapsBloc>(
        create: (context) => LapsBloc(context.read()),
      ),
      BlocProvider<StopwatchNotificationBloc>(create: (context) {
        final notificationHelper = context.read<NotificationHelper>();
        return StopwatchNotificationBloc(notificationHelper);
      }),
    ];
  }
}
