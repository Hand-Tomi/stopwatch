import 'package:flutter/material.dart';
import 'package:stopwatch/history_page_creator.dart';
import 'package:stopwatch/routes.dart';
import 'package:stopwatch/stopwatch_page_creator.dart';

class RoutesCreator {
  Map<String, WidgetBuilder> routes = {
    Routes.stopwatch: StopwatchPageCreator().create,
    Routes.history: HistoryPageCreator().create,
  };
}
