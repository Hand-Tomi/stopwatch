import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/history/history.dart';
import 'package:stopwatch/model/history.dart';
import 'package:stopwatch/repository/history_repository.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository _historyRepository;

  HistoryBloc(this._historyRepository) : super(HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case HistoryFetched:
        yield* _mapHistoryFetchedToState();
        break;
    }
  }

  Stream<HistoryState> _mapHistoryFetchedToState() async* {
    final historys = await _getHistorys();
    yield HistoryLoaded(historys);
  }

  Future<List<History>> _getHistorys() async {
    return (await _historyRepository.getHistorys()).toList();
  }
}
