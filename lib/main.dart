// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors,

import 'package:deliveryboy/global%20class/prefsname.dart';
import 'package:deliveryboy/page/authentication/login.dart';
import 'package:deliveryboy/page/home/home.dart';
import 'package:deliveryboy/theme/Theme.dart';
import 'package:deliveryboy/theme/Thememodel.dart';
import 'package:deliveryboy/Widget/splashscreen.dart';
import 'package:deliveryboy/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

String? userid;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getString(UD_user_id);
  runApp(ChangeNotifierProvider(
    create: (_) => Thememodel(),
    child: Consumer(builder: (context, Thememodel thememodel, child) {
      return EasyLocalization(
        path: 'Assets/translations',
        supportedLocales: const [Locale('en'), Locale('ar')],
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        child: Sizer(
          builder: (context, orientation, deviceType) => GetMaterialApp(
            scrollBehavior: MyBehavior(),
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: "Delivery boy",
            theme: thememodel.isDark ? MyThemes.DarkTheme : MyThemes.LightTheme,
            home: userid == null ? Login() : Home(),
          ),
        ),
      );
    }),
  ));
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

//  commmands for generate localization string file
//  flutter pub run easy_localization:generate -S "Assets/translations" -O "lib/translations"
//   flutter pub run easy_localization:generate -S "Assets/translations" -O "lib/translations" -o "locale_keys.g.dart"
//   flutter pub run easy_localization:generate -S "Assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys
