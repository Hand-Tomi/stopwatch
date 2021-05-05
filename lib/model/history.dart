import 'package:hive/hive.dart';

part 'history.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  @HiveField(0)
  final int msec;

  @HiveField(1)
  final DateTime savedAt;

  History(this.msec, this.savedAt);
}
