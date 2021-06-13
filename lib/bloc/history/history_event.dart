import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
  @override
  List<Object> get props => [];
}

class HistoryFetched extends HistoryEvent {
  const HistoryFetched();

  @override
  List<Object> get props => [];
}
