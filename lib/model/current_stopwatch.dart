import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'current_stopwatch.g.dart';

@HiveType(typeId: 4)
class CurrentStopwatch extends HiveObject with EquatableMixin {
  @HiveField(0)
  int start;

  @HiveField(1)
  int? stop;

  @HiveField(2)
  String historyKey;

  CurrentStopwatch({required this.start, this.stop, required this.historyKey});

  @override
  List<Object?> get props => [start, stop, historyKey];
}
