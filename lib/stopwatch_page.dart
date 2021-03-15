import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/stopwatch_event.dart';

import 'bloc/stopwatch_bloc.dart';
import 'bloc/stopwatch_state.dart';

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
                _timeText(),
                _lapTable(),
                _controller(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (conteseaxt, state) {
          return Text(
            getDisplayTime(state.msec),
            style: TextStyle(fontSize: 50.0),
          );
        },
      ),
    );
  }

  String getDisplayTime(int msec) {
    final minute = (msec / (60 * 1000)).floor().toString().padLeft(2, '0');
    final second =
        (msec % (60 * 1000) / 1000).floor().toString().padLeft(2, '0');
    final milliSecond = (msec % 1000 / 10).floor().toString().padLeft(2, '0');

    return '$minute:$second:$milliSecond';
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
    return Builder(
      builder: (context) {
        StopwatchBloc bloc =
            BlocProvider.of<StopwatchBloc>(context, listen: false);
        return Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: SizedBox(
            width: 60.0,
            height: 60.0,
            child: BlocBuilder<StopwatchBloc, StopwatchState>(
              builder: (context, state) {
                return IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: Icon(
                      state is StopwatchPlaying
                          ? Icons.pause_circle_filled_rounded
                          : Icons.play_circle_fill_rounded,
                      size: 60.0,
                    ),
                    onPressed: () {
                      if (state is StopwatchPlaying) {
                        bloc.add(StopwatchPaused());
                      } else {
                        bloc.add(StopwatchStarted());
                      }
                    });
              },
            ),
          ),
        );
      },
    );
  }
}
