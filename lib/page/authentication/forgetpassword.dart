// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:deliveryboy/config/api/api.dart';
import 'package:deliveryboy/model/forgotpassmodel.dart';
import 'package:deliveryboy/Widget/Loder.dart';
import 'package:deliveryboy/Widget/showdialog.dart';
import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/global%20class/height.dart';
import 'package:deliveryboy/theme/Thememodel.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:deliveryboy/validator/validation.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({Key? key}) : super(key: key);

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();

  ForgotpasswordAPI() async {
    loader.showLoading();
    var map = {
      "email": Email.value.text,
    };

    var response = await Dio()
        .post(defaultapi.appurl + Postapi.driverforgotPassword, data: map);

    forgot_passModel data = forgot_passModel.fromJson(response.data);

    if (data.status == 1) {
      Get.back();
      showdialog.showErroDialog(description: data.message);
    } else {
      showdialog.showErroDialog(description: data.message);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, Thememodel themenotifier, child) {
     return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 40,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                ),
              ),
              centerTitle: true,
              title: Text(
                LocaleKeys.Forgot_Password.tr(),
                style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 16.sp,color: themenotifier.isDark ? Colors.white : color.primarycolor),
              ),
            ),
            body: Form(
              key: _formkey,
              child: Container(
                margin: EdgeInsets.only(
                  left: 4.w,
                  top: 5.h,
                  right: 4.w,
                ),
                child: Column(
                  children: [
                    // Container(
                    //     alignment: Alignment.topLeft,
                    //     child: Text(LocaleKeys.Forgot_Password.tr(),
                    //         style: TextStyle(
                    //             fontSize: 22.sp,
                    //             fontWeight: FontWeight.bold,
                    //             fontFamily: 'Poppins_semiBold'))),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          LocaleKeys
                              .Enter_your_registered_email_address_below_We_will_send_new_password_in_your_email
                              .tr(),
                          style:
                          TextStyle(fontSize: 13.sp, fontFamily: 'Poppins'),
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      validator: (value) => Validators.validateEmail(value!),
                      cursorColor: Colors.grey,
                      controller: Email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: LocaleKeys.Email.tr(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:  BorderSide(color: themenotifier.isDark ? Colors.white : color.primarycolor,),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:  BorderSide(color: themenotifier.isDark ?Colors.white : color.primarycolor,),
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: themenotifier.isDark ?Colors.white : color.primarycolor,
                      ),
                      margin: EdgeInsets.only(
                        top: 3.h,
                      ),
                      height: 6.h,
                      width: double.infinity,
                      child: TextButton(
                        child: Text(
                          LocaleKeys.submit.tr(),
                          style: TextStyle(
                              fontFamily: 'Poppins_semiBold',
                              color: themenotifier.isDark ?Colors.black : color.white,
                              fontSize: fontsize.Buttonfontsize),
                        ),
                        onPressed: () {
                          if (defaultapi.environment == "sendbox") {
                            showdialog.showErroDialog(
                                description: LocaleKeys
                                    .This_operation_was_not_performed_due_to_demo_mode
                                    .tr());
                          } else if (_formkey.currentState!.validate()) {
                            ForgotpasswordAPI();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },);
  }
}
