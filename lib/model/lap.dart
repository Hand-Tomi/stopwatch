import 'package:equatable/equatable.dart';

class Lap extends Equatable {
  final int lap;
  final int lapTime;
  final int splitTime;

  Lap(this.lap, this.lapTime, this.splitTime);

  @override
  List<Object> get props => throw UnimplementedError();
}
