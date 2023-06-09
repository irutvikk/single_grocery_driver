// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:sizer/sizer.dart';

class showdialog {
  static void showErroDialog({String? description = 'Something went wrong'}) {
    Get.dialog(
      AlertDialog(
        title: Text(
          LocaleKeys.Grocery_Driver.tr(),
          style: TextStyle(fontSize: 14.sp, fontFamily: 'Poppins_semibold'),
        ),
        content: Text(
          description ?? '',
          style: TextStyle(fontSize: 12.sp, fontFamily: 'Poppins'),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color.primarycolor,
            ),
            onPressed: () {
              if (Get.isDialogOpen!) Get.back();
            },
            child: Text(
              LocaleKeys.Okay.tr(),
              style: TextStyle(color: color.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
