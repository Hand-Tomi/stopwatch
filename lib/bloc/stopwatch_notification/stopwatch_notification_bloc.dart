import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/notification/android_notification_details_wrapper.dart';
import 'package:stopwatch/notification/notification_helper.dart';
import 'package:stopwatch/util/msec_extensions.dart';

import 'stopwatch_notification.dart';

class StopwatchNotificationBloc
    extends Bloc<StopwatchNotificationEvent, StopwatchNotificationState> {
  static final String channelId = "stopwatch";
  static final String channelName = "stopwatch";
  static final String channelDescription = "Show stopwatch time";
  static final bool channelShowBadge = false;
  static final ImportanceWrapper importance = ImportanceWrapper.LOW;
  static final PriorityWrapper priority = PriorityWrapper.HIGH;
  static final bool playSound = false;
  static final bool enableVibration = false;
  static final bool onlyAlertOnce = true;
  static final AndroidNotificationDetailsWrapper notificationDetails =
      AndroidNotificationDetailsWrapper(
          channelId,
          channelName,
          channelDescription,
          channelShowBadge,
          importance,
          priority,
          playSound,
          enableVibration,
          onlyAlertOnce);

  static final int notificationId = 1000;
  static final String body = "Stopwatch";
  final NotificationHelper _notificationHelper;

  StopwatchNotificationBloc(this._notificationHelper)
      : super(StopwatchNotificationHiding());

  int _currentSeconds = 0;

  @override
  Stream<StopwatchNotificationState> mapEventToState(
      StopwatchNotificationEvent event) async* {
    switch (event.runtimeType) {
      case StopwatchNotificationShowed:
        yield* _mapStopwatchShowedToState(event as StopwatchNotificationShowed);
        break;
      case StopwatchNotificationHided:
        yield* _mapStopwatchHidedToState();
        break;
      default:
    }
  }

  Stream<StopwatchNotificationState> _mapStopwatchShowedToState(
      StopwatchNotificationShowed event) async* {
    final msec = event.msec;
    final newSeconds = msec ~/ 1000;

    if (_currentSeconds < newSeconds) {
      _currentSeconds = newSeconds;
      _notificationHelper.show(
        notificationDetails,
        notificationId,
        newSeconds.parseDisplayTimeOfSeconds(),
        body,
      );
    }

    yield StopwatchNotificationShowing();
  }

  Stream<StopwatchNotificationState> _mapStopwatchHidedToState() async* {
    _currentSeconds = 0;
    _notificationHelper.cancel(notificationId);
    yield StopwatchNotificationHiding();
  }
}
