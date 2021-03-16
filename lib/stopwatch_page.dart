import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/widget/stopwatch_joystick.dart';
import 'package:stopwatch/widget/stopwatch_time_text.dart';

import 'bloc/stopwatch_bloc.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: BlocProvider<StopwatchBloc>(
            create: (context) => StopwatchBloc(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StopwatchTimeText(),
                _lapTable(),
                StopwatchJoystick(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _lapTable() {
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
