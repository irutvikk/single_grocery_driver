// ignore_for_file: camel_case_types, prefer_const_constructors

import 'dart:convert';

import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/global%20class/prefsname.dart';
import 'package:deliveryboy/theme/Thememodel.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class aboutus extends StatefulWidget {
  const aboutus({Key? key}) : super(key: key);

  @override
  State<aboutus> createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  late WebViewController _controller;
  String aboutus = "";
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      aboutus = prefs.getString(ABOUT_US)!;
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Thememodel themenotifier, child) {
      return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 20,
                    )),
                title: Text(
                  LocaleKeys.About_Us.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 16.sp,
                      color: themenotifier.isDark ? Colors.white : color.primarycolor),
                ),
                centerTitle: true,
                leadingWidth: 40,
              ),
              body: WebViewWidget(
                  controller: WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..enableZoom(true)
                    ..loadRequest(Uri.dataFromString(aboutus,mimeType: 'text/html', encoding: Encoding.getByName('utf-8')),
                    )
              )));
    },);
  }

  // _loadHtmlFromAssets() async {
  //   _controller.loadUrl(Uri.dataFromString(aboutus,
  //           mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
  //       .toString());
  // }
}
