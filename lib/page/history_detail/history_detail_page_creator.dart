import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/history_detail/history_detail.dart';

import 'history_detail_page.dart';

class HistoryDetailPageCreator {
  Widget create(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProvider(),
      child: HistoryDetailPage(),
    );
  }

  List<BlocProvider> blocProvider() {
    return [
      BlocProvider<HistoryDetailBloc>(
        create: (context) => HistoryDetailBloc(
          context.read(),
        ),
      ),
    ];
  }
}
