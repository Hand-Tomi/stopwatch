import 'package:flutter/material.dart';
import 'package:stopwatch/routes.dart';
import 'package:stopwatch/stopwatch_page_creator.dart';

class RoutesCreator {
  Map<String, WidgetBuilder> routes = {
    Routes.stopwatch: StopwatchPageCreator().create,
  };
}
