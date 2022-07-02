import 'package:c9p/app/routes/app_pages.dart';
import 'package:c9p/app/utils/toast_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class NotificationService {
  // Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = "1";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    channelId,
    "thecodexhub",
    channelDescription:
        "This channel is responsible for all the local notifications",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  static const IOSNotificationDetails _iOSNotificationDetails =
      IOSNotificationDetails();

  final NotificationDetails notificationDetails = const NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _iOSNotificationDetails,
  );

  Future<void> init() async {
    // configFcm();
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iOSInitializationSettings = IOSInitializationSettings(
      defaultPresentAlert: false,
      defaultPresentBadge: false,
      defaultPresentSound: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    String? payload = notificationAppLaunchDetails!.payload;
    if (payload != null) {
      // Get.toNamed(Routes.YOUR_ORDER);
      /*     await navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => DetailsPage(payload: payload)));*/
      Fluttertoast.showToast(
        msg: payload,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14,
      );
    }
  }

  void configFcm() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      toast('FirebaseMessaging');
      var notification = message.notification;
      AndroidNotification? android = message.notification?.android;
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    toast('_firebaseMessagingBackgroundHandler');
    print('A bg message just showed up :  ${message.messageId}');
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotification(
      int id, String title, String body, String payload) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future<void> onSelectNotification(String? payload) async {
  Get.toNamed(Routes.YOUR_ORDER);
/*  await navigatorKey.currentState
      ?.push(MaterialPageRoute(builder: (_) => DetailsPage(payload: payload)));*/
}
