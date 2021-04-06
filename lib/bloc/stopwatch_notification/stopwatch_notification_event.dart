import 'package:equatable/equatable.dart';

class StopwatchNotificationEvent extends Equatable {
  const StopwatchNotificationEvent();

  @override
  List<Object?> get props => [];
}

class StopwatchNotificationShowed extends StopwatchNotificationEvent {
  final int msec;
  const StopwatchNotificationShowed(this.msec);
}

class StopwatchNotificationHided extends StopwatchNotificationEvent {
  const StopwatchNotificationHided() : super();
}
