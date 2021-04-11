import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stopwatch/notification/android_notification_details_wrapper.dart';

class NotificationHelper {
  static const iconFileName = 'app_icon';
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  NotificationHelper() {
    _initialize();
  }

  void _initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(iconFileName);
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // final MacOSInitializationSettings initializationSettingsMacOS =
    //     MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await plugin.initialize(initializationSettings);
  }

  Future<void> show(
    AndroidNotificationDetailsWrapper detailsWrapper,
    int notificationId,
    String title,
    String body,
  ) async {
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: detailsWrapper.raw);
    await plugin.show(
      notificationId,
      title,
      body,
      platformChannelSpecifics,
      payload: null,
    );
  }

  void cancel(int notificationId) {
    plugin.cancel(notificationId);
  }
}
