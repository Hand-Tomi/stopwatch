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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            timeText(),
            rapTable(),
            controller(),
          ],
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

  Widget _rapTable() {
    return Expanded(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              '랩',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              '랩타임',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              '시간',
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
    return IconButton(icon: Icon(Icons.play_arrow), onPressed: () {});
  }
}
