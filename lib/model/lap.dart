import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'lap.g.dart';

@HiveType(typeId: 2)
class Lap extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int lap;

  @HiveField(1)
  final int lapTime;

  @HiveField(2)
  final int splitTime;

  Lap(this.lap, this.lapTime, this.splitTime);

  @override
  List<Object?> get props => [lap, lapTime, splitTime];
}
