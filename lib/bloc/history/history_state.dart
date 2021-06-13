import 'package:equatable/equatable.dart';
import 'package:stopwatch/model/history.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {
  const HistoryInitial() : super();
}

class HistoryLoaded extends HistoryState {
  final List<History> historys;
  const HistoryLoaded(this.historys) : super();

  @override
  List<Object> get props => [historys];
}
