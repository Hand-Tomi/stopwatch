import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:stopwatch/model/history.dart';
import 'package:stopwatch/repository/history_repository.dart';
import 'package:stopwatch/util/date_time_extensions.dart';
import 'package:stopwatch/util/msec_extensions.dart';
import 'package:stopwatch/widget/list_divider.dart';

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
              final historyList = snapshot.data!.toList();
              return createGroupListView(context, historyList);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget createGroupListView(BuildContext context, List<History> historys) {
    return GroupedListView<History, String>(
      elements: historys,
      groupBy: (element) => element.savedAt.toDateString(),
      groupSeparatorBuilder: (value) => createGroupSeparator(context, value),
      itemBuilder: (context, element) => createSlidableTile(context, element),
      itemComparator: (element1, element2) =>
          element1.savedAt.compareTo(element2.savedAt),
      separator: ListDivider(),
      order: GroupedListOrder.DESC,
    );
  }

  Widget createGroupSeparator(BuildContext context, String title) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );
  }

  Widget createSlidableTile(BuildContext context, History history) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: [createDeleteAction()],
      child: createTile(context, history),
    );
  }

  Widget createTile(BuildContext context, History history) {
    return ListTile(
      title: Text(history.msec.parseDisplayTime()),
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: Icon(Icons.timer),
      ),
      subtitle: Text(
        history.savedAt.toDateTimeString(),
        style: Theme.of(context).textTheme.caption,
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }

  Widget createDeleteAction() {
    return IconSlideAction(
      caption: 'Delete',
      color: Colors.red,
      icon: Icons.delete,
      onTap: () => print('Delete'),
    );
  }
}
