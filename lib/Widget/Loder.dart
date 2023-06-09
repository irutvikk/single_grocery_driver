// ignore_for_file: prefer_const_constructors, file_names, unnecessary_import, camel_case_types

import 'package:deliveryboy/global%20class/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class loader {
  static void showLoading([String? message]) {
    Get.dialog(
      barrierDismissible: false,
      useSafeArea: true,
      barrierColor: Colors.transparent,
      Center(
          child: CircularProgressIndicator(
        color: color.primarycolor,
        strokeWidth: 5,
      )),
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
