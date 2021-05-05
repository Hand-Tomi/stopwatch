import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:stopwatch/model/history.dart';
import 'package:stopwatch/repository/history_repository.dart';
import 'package:stopwatch/util/date_time_extensions.dart';
import 'package:stopwatch/util/msec_extensions.dart';

class HistoryPage extends StatelessWidget {
  final String pageTitle = 'History';

  @override
  Widget build(BuildContext context) {
    final repository = context.read<HistoryRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: SafeArea(
        child: FutureBuilder<Iterable<History>>(
          future: repository.getHistorys(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GroupedListView<History, String>(
                elements: snapshot.data!.toList(),
                groupBy: (element) => element.savedAt.toDateString(),
                groupSeparatorBuilder: (value) =>
                    createGroupSeparator(context, value),
                itemBuilder: (context, element) => createTile(element),
                itemComparator: (element1, element2) =>
                    element1.savedAt.compareTo(element2.savedAt),
                order: GroupedListOrder.DESC,
              );
            } else {
              return Container();
            }
          },
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
