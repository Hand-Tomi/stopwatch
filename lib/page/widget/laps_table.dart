import 'package:flutter/material.dart';
import 'package:stopwatch/model/lap.dart';
import 'package:stopwatch/util/msec_extensions.dart';

class LapsTable extends StatefulWidget {
  final Stream<List<Lap>> streamLaps;

  LapsTable(this.streamLaps);

  @override
  _LapsTableState createState() => _LapsTableState();
}

class _LapsTableState extends State<LapsTable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Lap>>(
        stream: widget.streamLaps,
        builder: (context, snapshot) {
          final labs = snapshot.data;
          if (labs != null) {
            return createScrollView(labs);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget createScrollView(List<Lap> laps) {
    return SingleChildScrollView(
      child: DataTable(
        columns: <DataColumn>[
          createDataColumn(context, 'Lap'),
          createDataColumn(context, 'Lap Times'),
          createDataColumn(context, 'Split Time'),
        ],
        rows: lapsToRows(laps),
      ),
    );
  }

  List<DataRow> lapsToRows(List<Lap> laps) {
    return laps.reversed.map((lap) => createDataRow(lap)).toList();
  }

  DataColumn createDataColumn(BuildContext context, String title) {
    return DataColumn(
      label: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .subtitle2
            ?.copyWith(fontStyle: FontStyle.italic),
      ),
    );
  }

  DataRow createDataRow(Lap lap) {
    return DataRow(cells: <DataCell>[
      DataCell(Text('${lap.lap}')),
      DataCell(Text('${lap.lapTime.parseDisplayTime()}')),
      DataCell(Text('${lap.splitTime.parseDisplayTime()}')),
    ]);
  }
}
