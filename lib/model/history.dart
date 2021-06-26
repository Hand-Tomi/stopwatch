import 'package:hive/hive.dart';

import 'lap.dart';

part 'history.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  @HiveField(0)
  final int msec;

  @HiveField(1)
  final DateTime savedAt;

  @HiveField(2)
  final List<Lap>? laps;

  History(this.msec, this.savedAt, {this.laps});

  // 버그가 있어 `EquatableMixin`을 사용하면 테스트에서 에러가 발생하고 있어,
  // 임시로 이 함수를 이용해 비교하도록 한다.
  // https://github.com/felangel/equatable/issues/115
  bool isSame(History history) {
    return this.msec == history.msec && this.savedAt == history.savedAt;
  }

  History copyWith({int? msec, DateTime? savedAt, List<Lap>? laps}) => History(
        msec ?? this.msec,
        savedAt ?? this.savedAt,
        laps: laps ?? this.laps,
      );
}
