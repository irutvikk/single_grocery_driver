// ignore_for_file: camel_case_types,  prefer_const_constructors

import 'dart:convert';

import 'package:deliveryboy/model/cmspagemodel.dart';
import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:deliveryboy/config/api/API.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class privacypolicy extends StatefulWidget {
  const privacypolicy({Key? key}) : super(key: key);

  @override
  State<privacypolicy> createState() => _privacypolicyState();
}

class _privacypolicyState extends State<privacypolicy> {
  cmsMODEL? privacydata;
  String privacycode = "";

  privacyAPI() async {
    var resposne = await Dio().get(defaultapi.appurl + Getapi.cmspage);
    privacydata = cmsMODEL.fromJson(resposne.data);
    privacycode = privacydata!.privacypolicy!;
    return privacypolicy;
  }

  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
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
                LocaleKeys.Privacy_Policy.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 16,color: color.primarycolor),
              ),
              centerTitle: true,
              leadingWidth: 40,
            ),
            body: FutureBuilder(
              future: privacyAPI(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: color.primarycolor,
                    ),
                  );
                }
                return WebViewWidget(
                    controller: WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..enableZoom(true)
                      ..loadRequest(Uri.dataFromString(privacycode,mimeType: 'text/html', encoding: Encoding.getByName('utf-8')),
                      )
                );
              },
            )));
  }

  // _loadHtmlFromAssets() async {
  //   _controller.loadUrl(Uri.dataFromString(privacycode,
  //           mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
  //       .toString());
  // }
}
