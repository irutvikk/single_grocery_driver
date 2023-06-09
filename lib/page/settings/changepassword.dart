// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, use_build_context_synchronously

import 'package:deliveryboy/config/api/api.dart';
import 'package:deliveryboy/model/loginmodel.dart';
import 'package:deliveryboy/Widget/Loder.dart';
import 'package:deliveryboy/Widget/showdialog.dart';
import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/global%20class/height.dart';
import 'package:deliveryboy/global%20class/prefsname.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({Key? key}) : super(key: key);

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  TextEditingController Oldpass = TextEditingController();
  TextEditingController Newpass = TextEditingController();
  TextEditingController Confpass = TextEditingController();
  loginModel? changepassdata;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  _Changepassword() async {
    try {
      loader.showLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString(UD_user_id);

      var map = {
        "driver_id": prefs.getString(UD_user_id),
        "new_password": Newpass.text.toString(),
        "old_password": Oldpass.text.toString(),
      };

      var response = await Dio()
          .post(defaultapi.appurl + Postapi.driverchangepassword, data: map);

      var finallist = await response.data;
      changepassdata = loginModel.fromJson(finallist);

      loader.hideLoading();

      if (changepassdata!.status == 0) {
        showdialog.showErroDialog(
            description: changepassdata!.message.toString());
      } else if (changepassdata!.status == 1) {
        Oldpass.clear();
        Newpass.clear();
        Confpass.clear();
        Navigator.of(context).pop();
        showdialog.showErroDialog(description: "update password");
      }
    } catch (e) {
      showdialog.showErroDialog(description: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          LocaleKeys.Change_Password.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 16,color: color.primarycolor),
        ),
        centerTitle: true,
        leadingWidth: 40,
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(left: 4.w, top: 1.h, right: 4.w),
              child: Column(
                children: [
                  TextField(
                    obscureText: _obscureText1,
                    controller: Oldpass,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText1 = !_obscureText1;
                              });
                            },
                            icon: Icon(
                              _obscureText1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            )),
                        hintText: LocaleKeys.Old_Password.tr(),
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontSize: 10.5.sp),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide:  BorderSide(color: color.primarycolor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide:  BorderSide(color: color.primarycolor),
                        )),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextField(
                    obscureText: _obscureText2,
                    controller: Newpass,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                            icon: Icon(
                              _obscureText2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            )),
                        hintText: LocaleKeys.New_Password.tr(),
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontSize: 10.5.sp),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide:  BorderSide(color: color.primarycolor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide:  BorderSide(color: color.primarycolor),
                        )),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextField(
                    obscureText: _obscureText3,
                    cursorColor: Colors.grey,
                    controller: Confpass,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText3 = !_obscureText3;
                              });
                            },
                            icon: Icon(
                              _obscureText3
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            )),
                        hintText: LocaleKeys.Confirm_Password.tr(),
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontSize: 10.5.sp),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color.primarycolor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color.primarycolor),
                        )),
                  ),
                ],
              )),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (defaultapi.environment == "sendbox") {
            showdialog.showErroDialog(
                description: LocaleKeys
                    .This_operation_was_not_performed_due_to_demo_mode.tr());
          } else if (Oldpass.text.isEmpty) {
            showdialog.showErroDialog(
                description: LocaleKeys.Please_enter_all_details.tr());
          } else if (Newpass.text.isEmpty) {
            showdialog.showErroDialog(
                description: LocaleKeys.Please_enter_all_details.tr());
          } else if (Confpass.text.isEmpty) {
            showdialog.showErroDialog(
                description: LocaleKeys.Please_enter_all_details.tr());
          } else if (Newpass.text == Confpass.text) {
            _Changepassword();
          } else {
            showdialog.showErroDialog(
              description:
                  LocaleKeys.New_password_and_confirm_password_must_be_ame.tr(),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.only(
            left: 4.w,
            top: 1.h,
            right: 4.w,
            bottom: 1.h,
          ),
          height: 6.h,
          decoration: BoxDecoration(
              color: color.black, borderRadius: BorderRadius.circular(7)),
          child: Center(
            child: Text(
              LocaleKeys.reset.tr(),
              style: TextStyle(
                  fontFamily: 'Poppins_Bold',
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: fontsize.Buttonfontsize),
            ),
          ),
        ),
      ),
    );
  }
}
