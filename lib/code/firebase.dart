import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:poc_ifood_ordermanager/src/data/datasource/database_interface.dart';
import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';
import 'package:poc_ifood_ordermanager/src/pages/order_detail/order_detail_page.dart';

class FirebaseConfig {
  static Future<void> init(DataBase dataBase, NavigatorState navigator) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    const initializeSettings = InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(
      initializeSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload == null) return;
        final data = jsonDecode(details.payload!);
        final order = dataBase.get(data['id']);
        if (order == null) return;
        navigator.push(
          MaterialPageRoute(
            builder: (context) => OrderDetailPage(order: order),
          ),
        );
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>() //
        ?.createNotificationChannel(channel); //

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
    _initListen(flutterLocalNotificationsPlugin, channel, dataBase);
    _onTapMessage();
  }

  static _initListen(FlutterLocalNotificationsPlugin flutterNotification, AndroidNotificationChannel channel, DataBase dataBase) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification == null || android == null) return;
      if (message.data['pushType'] == 'new_order') {
        dataBase.put(OrderEntity.fromMap(message.data));
      }

      flutterNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode(message.data),
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
          ),
        ),
      );
    });
  }

  static _onTapMessage() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }
}
