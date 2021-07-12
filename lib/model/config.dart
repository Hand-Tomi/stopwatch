import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'config.g.dart';

@HiveType(typeId: 3)
class Config extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int? timeStarted;

  Config(this.timeStarted);

  @override
  List<Object?> get props => [timeStarted];
}
