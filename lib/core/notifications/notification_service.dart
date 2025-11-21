import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_video_stream_task/core/routing/app_router.dart';
import 'package:realtime_video_stream_task/core/routing/routes.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _local =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Android
    const AndroidInitializationSettings android =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS
    const DarwinInitializationSettings ios = DarwinInitializationSettings();

    await _local.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null) {
          _handleNavigationFromPayload(payload);
        }
      },
    );

    // Ask Permission iOS
    await FirebaseMessaging.instance.requestPermission();

    // Foreground message
    FirebaseMessaging.onMessage.listen((message) {
      _showLocalNotification(message);
    });

    // App open from TERMINATED
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNavigationFromPayload(message.data["video_url"] ?? "");
      }
    });

    // App open from BACKGROUND
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNavigationFromPayload(message.data["video_url"] ?? "");
    });
  }

  static void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;

    if (notification == null) return;

    const android = AndroidNotificationDetails(
      "video_channel",
      "Video Notifications",
      importance: Importance.max,
      priority: Priority.high,
    );

    const platform = NotificationDetails(android: android);

    _local.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platform,
      payload: message.data["video_url"] ?? "",
    );
  }

  static void _handleNavigationFromPayload(String payload) {
    if (payload.isEmpty) return;

    String type = "server"; // default
    String videoUrl = payload;

    // Detect YouTube links
    if (payload.contains("youtube.com") || payload.contains("youtu.be")) {
      type = "youtube";
      videoUrl = payload;
    } else {
      // Optionally parse custom payload URLs
      final uri = Uri.tryParse(payload);
      if (uri != null && uri.queryParameters.isNotEmpty) {
        videoUrl = uri.queryParameters["url"] ?? payload;
        type = uri.queryParameters["type"] ?? "server";
      }
    }

    rootNavigatorKey.currentContext?.go(
      "${Routes.videoPlayerScreen}?type=$type&url=$videoUrl",
    );
  }
}
