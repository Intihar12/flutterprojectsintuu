import 'package:antrakuserinc/data/data_bindings/data_bindings.dart';
import 'package:antrakuserinc/data/firebase_notification/firebase_notification.dart';
import 'package:antrakuserinc/ui/auth/splash.dart';
import 'package:antrakuserinc/ui/values/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseNotifications.instance.getDeviceToken();
  FirebaseNotifications.instance.initLocalNotification();
  FirebaseNotifications.instance.navigationOnFcm();

  /// for pdf download
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Styles.appTheme,

      getPages: [
        GetPage<void>(
          name: '/',
          page: () => SplashScreen(),
          binding: DataBindings(),
        ),
      ],
    );
  }
}
