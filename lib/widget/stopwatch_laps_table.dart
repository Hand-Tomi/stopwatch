import 'package:flutter/material.dart';

class StopwatchLapsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('3')),
              DataCell(Text('00:02:91')),
              DataCell(Text('00:13:19')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('2')),
              DataCell(Text('00:00:19')),
              DataCell(Text('00:10:28')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('1')),
              DataCell(Text('00:00:19')),
              DataCell(Text('00:10:08')),
            ],
          ),
        ],
      ),
    );
  }
}
