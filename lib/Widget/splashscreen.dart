// ignore_for_file: camel_case_types, prefer_const_constructors

import 'dart:async';
import 'package:deliveryboy/page/authentication/login.dart';
import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/main.dart';
import 'package:deliveryboy/config/network/internetcheck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class splashscree extends StatefulWidget {
  const splashscree({Key? key}) : super(key: key);

  @override
  State<splashscree> createState() => _splashscreeState();
}

int? initScreen;

class _splashscreeState extends State<splashscree> {
  @override
  void initState() {
    super.initState();
    data();
  }

  data() async {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    internet().conect();
    return SafeArea(
        child: Scaffold(
      backgroundColor: color.primarycolor,
      body: Center(
        child: Image.asset("Assets/Icons/ic_logo.png"),
      ),
    ));
  }
}

void showNotification() {
  flutterLocalNotificationsPlugin.show(
    0,
    "Testing  ",
    "How you doin ?",
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channel.description,
        importance: Importance.high,
        playSound: true,
        icon: '@drawable/ic_notification',
      ),
    ),
  );
}
