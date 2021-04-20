import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:stopwatch/model/history.dart';
import 'package:stopwatch/util/date_time_extensions.dart';
import 'package:stopwatch/util/msec_extensions.dart';

class HistoryPage extends StatelessWidget {
  final String pageTitle = 'History';
  final List<History> items = [
    History(
      100,
      DateTime.parse('2012-02-20 13:27:00'),
    ),
    History(
      100,
      DateTime.parse('2012-02-20 13:27:00'),
    ),
    History(
      100,
      DateTime.parse('2012-02-20 13:27:00'),
    ),
    History(
      100,
      DateTime.parse('2012-02-20 13:27:00'),
    ),
    History(
      100,
      DateTime.parse('2012-02-20 13:27:00'),
    ),
    History(
      100,
      DateTime.parse('2012-02-20 13:27:00'),
    ),
    History(
      100,
      DateTime.parse('2012-02-20 13:27:00'),
    ),
    History(
      100,
      DateTime.parse('2012-02-20 13:27:00'),
    ),
    History(
      100,
      DateTime.parse('2012-02-20 13:27:00'),
    ),
    History(
      200,
      DateTime.parse('2012-02-21 13:27:00'),
    ),
    History(
      200,
      DateTime.parse('2012-02-21 13:27:00'),
    ),
    History(
      200,
      DateTime.parse('2012-02-21 13:27:00'),
    ),
    History(
      200,
      DateTime.parse('2012-02-21 13:27:00'),
    ),
    History(
      200,
      DateTime.parse('2012-02-21 13:27:00'),
    ),
    History(
      200,
      DateTime.parse('2012-02-21 13:27:00'),
    ),
    History(
      200,
      DateTime.parse('2012-02-21 13:27:00'),
    ),
    History(
      300,
      DateTime.parse('2012-02-23 11:14:99'),
    ),
    History(
      300,
      DateTime.parse('2012-02-23 11:14:99'),
    ),
    History(
      300,
      DateTime.parse('2012-02-23 11:14:99'),
    ),
    History(
      300,
      DateTime.parse('2012-02-23 11:14:99'),
    ),
    History(
      300,
      DateTime.parse('2012-02-23 11:14:99'),
    ),
    History(
      300,
      DateTime.parse('2012-02-23 11:14:99'),
    ),
    History(
      300,
      DateTime.parse('2012-02-23 11:14:99'),
    ),
    History(
      400,
      DateTime.parse('2012-02-23 13:27:00'),
    ),
    History(
      500,
      DateTime.parse('2012-02-24 13:27:00'),
    ),
    History(
      600,
      DateTime.parse('2012-02-24 12:27:00'),
    ),
    History(
      600,
      DateTime.parse('2012-02-24 12:27:00'),
    ),
    History(
      600,
      DateTime.parse('2012-02-24 12:27:00'),
    ),
    History(
      600,
      DateTime.parse('2012-02-24 12:27:00'),
    ),
    History(
      600,
      DateTime.parse('2012-02-24 12:27:00'),
    ),
    History(
      600,
      DateTime.parse('2012-02-24 12:27:00'),
    ),
    History(
      600,
      DateTime.parse('2012-02-24 12:27:00'),
    ),
    History(
      600,
      DateTime.parse('2012-02-24 12:27:00'),
    ),
    History(
      600,
      DateTime.parse('2012-02-24 12:27:00'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: SafeArea(
        child: GroupedListView<History, String>(
          elements: items,
          groupBy: (element) => element.savedAt.toDateString(),
          groupSeparatorBuilder: (value) =>
              createGroupSeparator(context, value),
          itemBuilder: (context, element) => createTile(element),
          itemComparator: (element1, element2) =>
              element1.savedAt.compareTo(element2.savedAt),
          order: GroupedListOrder.DESC,
        ),
      ),
    );
  }

  Widget createGroupSeparator(BuildContext context, String title) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: Text(title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );
  }

  Widget createTile(History history) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: ListTile(
        title: Text(history.msec.parseDisplayTime()),
        leading: Icon(Icons.timer),
        subtitle: Text(
          history.savedAt.toDateTimeString(),
          style: TextStyle(fontSize: 12),
        ),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
