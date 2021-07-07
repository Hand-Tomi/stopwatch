import 'package:equatable/equatable.dart';

abstract class HistoryDetailEvent extends Equatable {
  const HistoryDetailEvent();
  @override
  List<Object> get props => [];
}

class HistoryDetailFetched extends HistoryDetailEvent {
  final dynamic historyKey;
  const HistoryDetailFetched(this.historyKey);

  @override
  List<Object> get props => [];
}

class HistoryDetailDeleted extends HistoryDetailEvent {
  final dynamic historyKey;
  const HistoryDetailDeleted(this.historyKey);

  @override
  List<Object> get props => [];
}
