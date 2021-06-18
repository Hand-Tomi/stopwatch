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

class HistoryLoading extends HistoryState {
  final List<History> historys;
  const HistoryLoading(this.historys) : super();

  @override
  List<Object> get props => [historys];
}
