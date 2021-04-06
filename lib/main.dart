import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/bloc/stopwatch_notification/stopwatch_notification_bloc.dart';
import 'package:stopwatch/replicator.dart';
import 'package:stopwatch/stopwatch_page.dart';
import 'package:stopwatch/notification/notification_helper.dart';

import 'bloc/laps/laps.dart';
import 'bloc/stopwatch/stopwatch.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationHelper>(
          create: (_) => NotificationHelper(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: stopwatchPage(),
    );
  }

  Widget stopwatchPage() {
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
          stopwatch: Stopwatch(),
          replcator: Replicator(_updateInterval),
        ),
      ),
      BlocProvider<LapsBloc>(
        create: (context) => LapsBloc(),
      ),
    ];
  }
}
