import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/history_detail/history_detail.dart';
import 'package:stopwatch/repository/history_repository.dart';

class HistoryDetailBloc extends Bloc<HistoryDetailEvent, HistoryDetailState> {
  final HistoryRepository _historyRepository;

  HistoryDetailBloc(this._historyRepository) : super(HistoryDetailInitial());

  @override
  Stream<HistoryDetailState> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case HistoryDetailFetched:
        yield* _mapHistoryFetchedToState(
            (event as HistoryDetailFetched).historyKey);
        break;
    }
  }

  Stream<HistoryDetailState> _mapHistoryFetchedToState(historyKey) async* {
    final history = await _historyRepository.getHistory(historyKey);
    if (history != null) {
      yield HistoryDetailLoading(history);
    }
  }
}
