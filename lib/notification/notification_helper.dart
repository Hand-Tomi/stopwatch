import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    int notificationId,
    String channelId,
    String channelName,
    String channelDescription,
    String title,
    String body,
  ) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      channelShowBadge: false,
      importance: Importance.low,
      priority: Priority.high,
      playSound: false,
      enableVibration: false,
      onlyAlertOnce: true,
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
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
