import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/history_detail/history_detail.dart';
import 'package:stopwatch/page/history_detail/history_detail_aguments.dart';
import 'package:stopwatch/page/widget/laps_table.dart';

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
                _lapsTable(state),
              ],
            );
          },
        ),
      )),
    );
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

  void _fetchData() {
    bloc.add(HistoryDetailFetched(arguments.historyKey));
  }
}
