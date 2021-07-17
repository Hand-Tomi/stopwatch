import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'current_stopwatch.dart';

part 'config.g.dart';

@HiveType(typeId: 3)
class Config extends HiveObject with EquatableMixin {
  @HiveField(0)
  final CurrentStopwatch? currentStopwatch;

  Config(this.currentStopwatch);

  Config copyWith({CurrentStopwatch? currentStopwatch}) =>
      Config(currentStopwatch);

  @override
  List<Object?> get props => [currentStopwatch];
}
