import 'package:equatable/equatable.dart';

class StopwatchNotificationState extends Equatable {
  const StopwatchNotificationState();

  @override
  List<Object?> get props => [];
}

class StopwatchNotificationShowing extends StopwatchNotificationState {
  const StopwatchNotificationShowing() : super();
}

class StopwatchNotificationHiding extends StopwatchNotificationState {
  const StopwatchNotificationHiding() : super();
}
