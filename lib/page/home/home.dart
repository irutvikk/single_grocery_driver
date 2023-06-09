// ignore_for_file: file_names,  prefer_const_constructors

import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/page/home/homepage.dart';
import 'package:deliveryboy/page/orders/orderdetails.dart';
import 'package:deliveryboy/page/orders/orderhistory.dart';
import 'package:deliveryboy/page/settings/profile.dart';
import 'package:deliveryboy/Widget/showdialog.dart';
import 'package:deliveryboy/global%20class/height.dart';
import 'package:deliveryboy/main.dart';
import 'package:deliveryboy/theme/Thememodel.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selelectedindex = 0;
  PageController pageController = PageController();
  void opTapped(int index) {
    setState(() {
      _selelectedindex = index;

      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 1),
        curve: Curves.ease,
      );
    });
  }

  Future<dynamic> onSelectNotification(payload) async {
    isnotificationopen = 1;

    showdialog.showErroDialog(
        description: "is notificationopen $isnotificationopen");

    Get.to(() => orderdetails("123"));
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance;

    var initializationsettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationsettingsAndroid);
    FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                icon: '@drawable/ic_notification',
                channel.id,
                channel.name,
                channel.description
              ),
            ),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Get.to(() => orderdetails("171"));
        showdialog.showErroDialog(description: "sfggfgdfdsd");
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ));
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Thememodel themenotifier, child) {
      return WillPopScope(
        onWillPop: () async {
          final value = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  LocaleKeys.Grocery_Driver.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins_semibold",
                  ),
                ),
                content: Text(
                  LocaleKeys.Are_you_sure_to_exit_from_this_app.tr(),
                  style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color.primarycolor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      LocaleKeys.No.tr(),
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: color.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color.primarycolor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      LocaleKeys.Yes.tr(),
                      style: TextStyle(
                        fontSize: 14,
                        color: color.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          if (value != null) {
            return Future.value(value);
          } else {
            return Future.value(false);
          }
        },
        child: Scaffold(
          body: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: const [
              Homepage(),
              Orderhistory(),
              Profile(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'Assets/svgicon/Home.svg',
                  height: height.bottombaricon,
                  color: themenotifier.isDark ? Colors.white : color.primarycolor,
                ),
                label: "",
                activeIcon: SvgPicture.asset(
                  'Assets/svgicon/Homedark.svg',
                  height: height.bottombaricon,
                  color: themenotifier.isDark ? Colors.white : color.primarycolor,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'Assets/svgicon/Order.svg',
                  height: height.bottombaricon,
                  color: themenotifier.isDark ? Colors.white : color.primarycolor,
                ),
                label: "",
                activeIcon: SvgPicture.asset(
                  'Assets/svgicon/Orderdark.svg',
                  height: height.bottombaricon,
                  color: themenotifier.isDark ? Colors.white : color.primarycolor,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'Assets/svgicon/Profile.svg',
                  height: height.bottombaricon,
                  color: themenotifier.isDark ? Colors.white : color.primarycolor,
                ),
                label: "",
                activeIcon: SvgPicture.asset(
                  'Assets/svgicon/Profiledark.svg',
                  height: height.bottombaricon,
                  color: themenotifier.isDark ? Colors.white : color.primarycolor,
                ),
              ),
            ],
            currentIndex: _selelectedindex,
            type: BottomNavigationBarType.fixed,
            onTap: opTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
      );
    });
  }
}

int isnotificationopen = 0;
