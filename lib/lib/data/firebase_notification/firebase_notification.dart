import 'dart:io';

import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../ui/chat/order_chat_screen.dart';
import '../../ui/rating_tip/rating_tip.dart';

class FirebaseNotifications {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static String? deviceToken;
  Map<String, dynamic>? data;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static FirebaseNotifications get instance => FirebaseNotifications();

  Future<String?> getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) {
        deviceToken = token;
        SingleToneValue.instance.dvToken = deviceToken;
        print("Dv token ${SingleToneValue.instance.dvToken}");
      }
    }).catchError((onError) {
      print("the error is $onError");
    });
    return deviceToken;
  }

  Future _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    print('Handling a background message $body');
  }

  Future _selectNotification(String? payload) async {}
  Future initLocalNotification() async {
    if (Platform.isIOS) {
      // set iOS Local notification.
      print("Inside ios");
      var initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    } else {
      var initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }
  }

  Future navigationOnFcm() async {
    try {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
      // onMessage is called in foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
        //data = message.data;
        // String name = data!["name"];
        // String id = data!["order_id"];
        // print("name ::::::::::::: $name  $id");

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification!.android;
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          // description
          importance: Importance.max,
        );
        void pushShowNotification(int code, String title, String message) {
          _flutterLocalNotificationsPlugin.show(
            code,
            title,
            message,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in sigitechnologies app.
                  icon: 'launch_background',
                ),
                iOS: IOSNotificationDetails(
                  presentSound: true,
                  presentAlert: true,
                )),
          );
        }

        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in sigitechnologies app.
                  icon: 'launch_background',
                ),
                iOS: IOSNotificationDetails(
                  presentSound: true,
                  presentAlert: true,
                )),
          );
        }

        pushShowNotification(message.notification.hashCode,
            message.notification!.title!, message.notification!.body!);
        // if(GetUtils.isCaseInsensitiveContains(message.notification!.title!, "Request")){

        data = message.data;

        if (data!["ride_completed"] == "true") {
          SingleToneValue.instance.rideCompleted = data!["ride_completed"];
          Get.off(() => RatingTip());
        }

        if (message.notification!.title == "chat messages") {
          data = message.data;
          pushShowNotification(message.notification.hashCode,
              message.notification!.title!, message.notification!.body!);
          String name = data!["my_name"];
          int requestId = int.parse(data!["order_id"]);
          SingleToneValue.instance.driverID = data!["myId"];
          SingleToneValue.instance.driverDv = data!["my_dvToken"];
          Get.to(OrderChatPage(
            requestId: requestId,
            theirName: name,
            orderID: requestId.toString(),
          ));
        }
        /*if(message.notification!.title! == "Complete"){
          pushShowNotification(
              message.notification.hashCode,
              message.notification!.title!,
              message.notification!.body!);
          Get.offAll(ReviewScreen());
        }*/
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('app is open');
        print('A new onMessageOpenedApp event was published!');
        print(message.notification!.title!);
        data = message.data;
        String name = data!["my_name"];
        int requestId = int.parse(data!["order_id"]);
        SingleToneValue.instance.driverID = data!["myId"];
        SingleToneValue.instance.driverDv = data!["my_dvToken"];
        Get.to(OrderChatPage(
          requestId: requestId,
          theirName: name,
          orderID: requestId.toString(),
        ));
        if (message.notification!.title == "chat messages") {}
      });

      // FirebaseMessaging.instance.getInitialMessage().then((message){
      //   if(message !=null) {
      //     data = message.data;
      //     String name = data!["my_name"];
      //     int requestId = int.parse(data!["order_id"]);
      //     SingleToneValue.instance.driverID = data!["myId"];
      //     SingleToneValue.instance.driverDv = data!["my_dvToken"];
      //     Get.to(OrderChatPage(requestId: requestId, theirName: name));
      //   }
      //   // This gets called 4 times, every time gets called when app is restarted or I navigate back using pushReplacement()
      // });

    } catch (e) {
      print(e.toString());
    }
  }
}
