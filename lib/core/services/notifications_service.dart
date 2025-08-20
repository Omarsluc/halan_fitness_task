import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);
  }

  Future<void> showWorkoutReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'workout_channel',
      'Workout Reminders',
      channelDescription: 'Notifications for workout reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      1,
      'Time for your workout!',
      'Don\'t forget to log your exercises today',
      details,
    );
  }

  Future<void> showWorkoutCompleted() async {
    const androidDetails = AndroidNotificationDetails(
      'workout_channel',
      'Workout Completed',
      channelDescription: 'Notifications for completed workouts',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      2,
      'Great job! 💪',
      'Workout logged successfully',
      details,
    );
  }
}
