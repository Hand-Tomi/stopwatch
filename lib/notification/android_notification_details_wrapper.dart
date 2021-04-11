import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum ImportanceWrapper {
  NONE,
  MIN,

  /// 화면에 나타나지 않고, 통지리스트에 추가됨.
  LOW,

  DEFAULT,
  HIGH,
  MAX,
}

enum PriorityWrapper { MIN, LOW, DEFAULT, HIGH, MAX }

class AndroidNotificationDetailsWrapper {
  late AndroidNotificationDetails _details;

  get raw => _details;

  AndroidNotificationDetailsWrapper(
    String channelId,
    String channelName,
    String channelDescription,
    bool channelShowBadge,
    ImportanceWrapper importance,
    PriorityWrapper priority,
    bool playSound,
    bool enableVibration,
    bool onlyAlertOnce,
  ) {
    _details = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      channelShowBadge: channelShowBadge,
      importance: importance.raw(),
      priority: priority.raw(),
      playSound: playSound,
      enableVibration: enableVibration,
      onlyAlertOnce: onlyAlertOnce,
    );
  }
}

extension ImportanceParsing on ImportanceWrapper {
  Importance raw() {
    switch (this) {
      case ImportanceWrapper.NONE:
        return Importance.none;
      case ImportanceWrapper.MIN:
        return Importance.min;
      case ImportanceWrapper.LOW:
        return Importance.low;
      case ImportanceWrapper.DEFAULT:
        return Importance.defaultImportance;
      case ImportanceWrapper.HIGH:
        return Importance.high;
      case ImportanceWrapper.MAX:
        return Importance.max;
    }
  }
}

extension PriorityParsing on PriorityWrapper {
  Priority raw() {
    switch (this) {
      case PriorityWrapper.MIN:
        return Priority.min;
      case PriorityWrapper.LOW:
        return Priority.low;
      case PriorityWrapper.DEFAULT:
        return Priority.defaultPriority;
      case PriorityWrapper.HIGH:
        return Priority.high;
      case PriorityWrapper.MAX:
        return Priority.max;
    }
  }
}
