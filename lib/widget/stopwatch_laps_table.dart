import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/laps/laps.dart';
import 'package:stopwatch/model/lap.dart';

class StopwatchLapsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<LapsBloc, List<Lap>>(
        builder: (context, state) {
          return DataTable(
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
          );
        },
      ),
    );
  }

  DataRow createDataRow(Lap lap) {
    return DataRow(cells: <DataCell>[
      DataCell(Text('${lap.lap}')),
      DataCell(Text('${_getDisplayTime(lap.lapTime)}')),
      DataCell(Text('${_getDisplayTime(lap.splitTime)}')),
    ]);
  }

  String _getDisplayTime(int msec) {
    final minute = (msec / (60 * 1000)).floor().toString().padLeft(2, '0');
    final second =
        (msec % (60 * 1000) / 1000).floor().toString().padLeft(2, '0');
    final milliSecond = (msec % 1000 / 10).floor().toString().padLeft(2, '0');

    return '$minute:$second:$milliSecond';
  }
}
