import 'package:equatable/equatable.dart';

class History extends Equatable {
  final int msec;
  final DateTime savedAt;

  History(this.msec, this.savedAt);

  @override
  List<Object?> get props => [msec, savedAt];
}
