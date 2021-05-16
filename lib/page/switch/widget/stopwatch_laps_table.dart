import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/model/lap.dart';
import 'package:stopwatch/util/msec_extensions.dart';

class StopwatchLapsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<LapsBloc, List<Lap>>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: DataTable(
              columns: <DataColumn>[
                createDataColumn(context, 'Lap'),
                createDataColumn(context, 'Lap Times'),
                createDataColumn(context, 'Split Time'),
              ],
              rows: state.reversed.map((lap) => createDataRow(lap)).toList(),
            ),
          );
        },
      ),
    );
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
