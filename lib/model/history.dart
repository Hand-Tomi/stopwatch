import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'lap.dart';

part 'history.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int msec;

  @HiveField(1)
  final DateTime savedAt;

  @HiveField(2)
  final List<Lap>? laps;

  History(this.msec, this.savedAt, {this.laps});

  History copyWith({int? msec, DateTime? savedAt, List<Lap>? laps}) => History(
        msec ?? this.msec,
        savedAt ?? this.savedAt,
        laps: laps ?? this.laps,
      );

  @override
  List<Object?> get props => [msec, savedAt, laps];
}
