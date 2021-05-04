import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/core/app_theme.dart';
import 'package:stopwatch/database/database.dart';
import 'package:stopwatch/database/hive/database_impl.dart';
import 'package:stopwatch/repository/history_repository.dart';
import 'package:stopwatch/routes_creator.dart';
import 'package:stopwatch/notification/notification_helper.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationHelper>(
          create: (_) => NotificationHelper(),
          lazy: false,
        ),
        Provider<Database>(
          create: (context) {
            return DatabaseImps()..init();
          },
        ),
        Provider<HistoryRepository>(
          create: (context) => HistoryRepository(context.read()),
        )
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
      theme: AppTheme.theme,
      routes: RoutesCreator().routes,
    );
  }
}
