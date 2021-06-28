import 'package:equatable/equatable.dart';
import 'package:stopwatch/model/history.dart';

abstract class HistoryDetailState extends Equatable {
  const HistoryDetailState();

  @override
  List<Object> get props => [];
}

class HistoryDetailInitial extends HistoryDetailState {
  const HistoryDetailInitial() : super();
}

class HistoryDetailLoading extends HistoryDetailState {
  final History history;
  const HistoryDetailLoading(this.history) : super();

  @override
  List<Object> get props => [history];
}
