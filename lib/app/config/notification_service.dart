import 'dart:async';

import 'package:c9p/app/config/globals.dart' as globals;
import 'package:c9p/app/data/event_bus/new_notify_event.dart';
import 'package:c9p/app/data/event_bus/refresh_order_detail_event.dart';
import 'package:c9p/app/data/event_bus/refresh_your_order_event.dart';
import 'package:c9p/app/data/event_bus/show_badge_event.dart';
import 'package:c9p/app/utils/app_utils.dart';
import 'package:c9p/app/utils/storage_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../data/model/notify_model.dart';

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
    "notifications",
    channelDescription: "notifications",
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
    configFcm();
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
      StorageUtils.saveOrderId(payload);
    }
  }

  void configFcm() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var notifyModel = NotifyModel.fromJson(message.data);
      if (globals.isOrderDetail) {
        Utils.fireEvent(RefreshOrderDetailEvent(notifyModel.orderId ?? '  '));
      } else if (globals.isOpenYourOrder) {
        Utils.fireEvent(RefreshYourOrderEvent());
      } else {
        if (notifyModel.orderId != null && notifyModel.orderId!.isNotEmpty) {
          Utils.fireEvent(ShowBadgeEvent());
        }
      }
      showNotification(message);
    });
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
    RemoteMessage message,
  ) async {
    var notifyModel = NotifyModel.fromJson(message.data);
    await flutterLocalNotificationsPlugin.show(
      message.messageId.hashCode,
      notifyModel.orderStatus,
      notifyModel.msg,
      notificationDetails,
      payload: notifyModel.orderId,
    );
  }

  Future<void> cancelNotification(int id) async =>
      await flutterLocalNotificationsPlugin.cancel(id);

  Future<void> cancelAllNotifications() async =>
      await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> onSelectNotification(String? payload) async => Timer(
    const Duration(seconds: 1),
    () => Utils.fireEvent(NewNotifyEvent(payload ?? '')));
