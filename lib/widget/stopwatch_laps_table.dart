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
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Lab',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Lap Times',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Time',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: state.map((lap) => createDataRow(lap)).toList(),
            ),
          );
        },
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
