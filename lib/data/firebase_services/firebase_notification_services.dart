import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationServices {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotifications(RemoteMessage message) async {
    var androidInitalization =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitalization = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitalization,
      iOS: iosInitalization,
    );
    await localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payloads) {
        log("Payloads == $payloads");
      },
    );
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        log(message.data.toString());
        initLocalNotifications(message);
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidChannel =
        const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );
    AndroidNotificationDetails andRoidNotificationDetails =
        AndroidNotificationDetails(androidChannel.id, androidChannel.name,
            importance: Importance.max,
            priority: Priority.max,
            ticker: "ticker",
            channelDescription: "notification channal description");
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: andRoidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    Future.delayed(Duration.zero, () {
      localNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<void> requestNotificationPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: true,
      criticalAlert: true,
      announcement: true,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("User granted notification permissions");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log("User granted provisional notification permissions");
    } else {
      log("User denied notification permissions");
    }
  }

  Future<String> getDeviceToken() async {
    String? result = await messaging.getToken();
    return result!;
  }

  void refreshToken() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      log(event.toString());
    });
  }
}
