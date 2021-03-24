import 'package:equatable/equatable.dart';
import 'package:stopwatch/model/lap.dart';

abstract class LapsEvent extends Equatable {
  const LapsEvent();
  @override
  List<Object> get props => [];
}

class LapsAdded extends LapsEvent {
  final Lap lap;

  const LapsAdded(this.lap);

  @override
  List<Object> get props => [lap];
}

class LapsCleared extends LapsEvent {
  const LapsCleared();

  @override
  List<Object> get props => [];
}
