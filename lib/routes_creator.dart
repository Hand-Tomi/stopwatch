import 'package:flutter/material.dart';
import 'package:stopwatch/page/history/history_page_creator.dart';
import 'package:stopwatch/page/history_detail/history_detail_page.dart';
import 'package:stopwatch/routes.dart';
import 'package:stopwatch/page/switch/stopwatch_page_creator.dart';

class RoutesCreator {
  Map<String, WidgetBuilder> routes = {
    Routes.stopwatch: StopwatchPageCreator().create,
    Routes.history: HistoryPageCreator().create,
    Routes.historyDetail: (_) => HistoryDetailPage(),
  };
}
