import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/history/history.dart';
import 'package:stopwatch/page/history/history_page.dart';

class HistoryPageCreator {
  Widget create(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProvider(),
      child: HistoryPage(),
    );
  }

  List<BlocProvider> blocProvider() {
    return [
      BlocProvider<HistoryBloc>(
        create: (context) => HistoryBloc(
          context.read(),
        ),
      ),
    ];
  }
}
