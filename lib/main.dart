import 'dart:io';

import 'package:c9p/app/utils/storage_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/config/app_translation.dart';
import 'app/config/notification_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/root_binding.dart';
import 'app/utils/toast_utils.dart';

void main() async {
  await configApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (w, c) => GetMaterialApp(
        // initialBinding: RootBinding(),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          textTheme: GoogleFonts.mulishTextTheme(),
          backgroundColor: Colors.white,
          primaryColor: Colors.white,
          bottomAppBarColor: Colors.yellow,
          dividerColor: Colors.transparent,
          // canvasColor: Colors.transparent,
          shadowColor: Colors.transparent,
          appBarTheme: const AppBarTheme(elevation: 0),
        ),
        defaultTransition: Transition.native,
        translations: AppTranslation(),
        locale: Get.deviceLocale,
        fallbackLocale: AppTranslation.fallbackLocale,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: true,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> configApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  configOrientation();
  await GetStorage.init();
  configFcm();
  await dotenv.load(fileName: '.env.dev');
  await StorageUtils.getUser();
  var notificationService = NotificationService();
  await notificationService.init();
  await notificationService.requestIOSPermissions();
}

void configOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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