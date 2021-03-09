import 'package:flutter/material.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _timeText(),
              _lapTable(),
              _controller(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: Text(
        '00:13:19',
        style: TextStyle(fontSize: 50.0),
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

  Widget _controller() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: SizedBox(
        width: 60.0,
        height: 60.0,
        child: IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: Icon(
              Icons.play_circle_fill_rounded,
              size: 60.0,
            ),
            onPressed: () {}),
      ),
    );
  }
}
