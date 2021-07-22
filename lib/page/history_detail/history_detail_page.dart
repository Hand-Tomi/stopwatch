import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/history_detail/history_detail.dart';
import 'package:stopwatch/page/history_detail/history_detail_aguments.dart';
import 'package:stopwatch/page/widget/laps_table.dart';
import 'package:stopwatch/routes.dart';
import 'package:stopwatch/util/date_time_extensions.dart';
import 'package:stopwatch/util/msec_extensions.dart';

class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({Key? key}) : super(key: key);

  @override
  _HistoryDetailPageState createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  final String _pageTitle = 'History detail';

  late final HistoryDetailArguments arguments =
      ModalRoute.of(context)!.settings.arguments as HistoryDetailArguments;

  late final HistoryDetailBloc bloc = context.read<HistoryDetailBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle),
      ),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<HistoryDetailBloc, HistoryDetailState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _timeText(state),
                _savedAt(state),
                _lapsTable(state),
                _deleteButton(state)
              ],
            );
          },
        ),
      )),
    );
  }

  Widget _timeText(HistoryDetailState state) {
    switch (state.runtimeType) {
      case HistoryDetailLoading:
        final msec = (state as HistoryDetailLoading).history.msec;
        final displayTime = msec.parseDisplayTime();
        return Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            displayTime,
            style: Theme.of(context).textTheme.headline1,
          ),
        );
      default:
        return Container();
    }
  }

  Widget _savedAt(HistoryDetailState state) {
    switch (state.runtimeType) {
      case HistoryDetailLoading:
        final savedAt = (state as HistoryDetailLoading).history.savedAt;
        return Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Text(
            "Saved at " + savedAt.toDateTimeString(),
            style: Theme.of(context).textTheme.caption,
          ),
        );
      default:
        return Container();
    }
  }

  Widget _lapsTable(HistoryDetailState state) {
    switch (state.runtimeType) {
      case HistoryDetailLoading:
        final laps = (state as HistoryDetailLoading).history.laps;
        if (laps != null) {
          return LapsTable(Stream.value(laps));
        } else {
          return LapsTable(Stream.empty());
        }
      default:
        return Container();
    }
  }

  Widget _deleteButton(HistoryDetailState state) {
    switch (state.runtimeType) {
      case HistoryDetailLoading:
        final running = (state as HistoryDetailLoading).history.running;
        if (running) {
          return Container();
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.red),
              onPressed: () {
                _showMyDialog();
              },
              child: Text('Delete'),
            ),
          );
        }
      default:
        return Container();
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              style: TextButton.styleFrom(primary: Colors.red),
              onPressed: _agreeToDelete,
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: _pop,
            ),
          ],
        );
      },
    );
  }

  void _agreeToDelete() {
    bloc.add(HistoryDetailDeleted(arguments.historyKey));
    _popToHistory();
  }

  void _popToHistory() {
    Navigator.popUntil(context, ModalRoute.withName(Routes.history));
  }

  void _pop() {
    Navigator.of(context).pop();
  }

  void _fetchData() {
    bloc.add(HistoryDetailFetched(arguments.historyKey));
  }
}
