// ignore_for_file: use_build_context_synchronously, file_names, non_constant_identifier_names,  prefer_const_constructors

import 'package:deliveryboy/config/api/api.dart';
import 'package:deliveryboy/model/loginmodel.dart';
import 'package:deliveryboy/page/authentication/forgetpassword.dart';
import 'package:deliveryboy/page/home/home.dart';
import 'package:deliveryboy/Widget/Loder.dart';
import 'package:deliveryboy/Widget/showdialog.dart';
import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/global%20class/height.dart';
import 'package:deliveryboy/global%20class/prefsname.dart';
import 'package:deliveryboy/theme/Thememodel.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:deliveryboy/validator/validation.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../home/homepage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();
  loginModel? logindata;

  String? Logintype = "";
  String? countrycode = "91";

  _loginAPI() async {
    loader.showLoading();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var map = {
        "email": Email.value.text,
        "password": password.value.text,
        "token": Googletoken,
      };

      var response = await Dio().post(
        defaultapi.appurl + Postapi.driverlogin,
        data: map,
      );

      logindata = loginModel.fromJson(response.data);
      loader.hideLoading();
      if (logindata!.status == 1) {
        prefs.setString(UD_user_id, logindata!.data!.id.toString());
        prefs.setString(UD_user_name, logindata!.data!.name.toString());
        prefs.setString(UD_user_mobile, logindata!.data!.mobile.toString());
        prefs.setString(UD_user_email, logindata!.data!.email.toString());
        prefs.setString(
            UD_user_profile, logindata!.data!.profileImage.toString());
        prefs.setString(
            UD_user_isnotification, logindata!.data!.isNotification.toString());
        prefs.setString(UD_user_ismail, logindata!.data!.isMail.toString());
        prefs.setString(
            UD_user_referralcode, logindata!.data!.referralCode.toString());
        prefs.setString(UD_user_wallet, logindata!.data!.wallet.toString());
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        showdialog.showErroDialog(description: logindata!.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  token() async {
    if (defaultapi.environment == "sendbox") {
      setState(() {
        Email.value = TextEditingValue(text: "driver1@yopmail.com");
        password.value = TextEditingValue(text: "123456");
      });
    }
    await FirebaseMessaging.instance.getToken().then((token) {
      Googletoken = token!;
    });
  }

  String? Googletoken;

  @override
  void initState() {
    super.initState();
    token();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Thememodel themenotifier, child) {
      return SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            final value = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    LocaleKeys.Grocery_Driver.tr(),
                    style:
                    TextStyle(fontSize: 18, fontFamily: "Poppins_semibold"),
                  ),
                  content: Text(
                    LocaleKeys.Are_you_sure_to_exit_from_this_app.tr(),
                    style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themenotifier.isDark ?Colors.white : color.primarycolor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        LocaleKeys.No.tr(),
                        style: TextStyle(
                            fontSize: 16,
                            color: themenotifier.isDark ?Colors.black : color.white,
                            fontFamily: "Poppins"),
                      ),
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themenotifier.isDark ?Colors.white : color.primarycolor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        LocaleKeys.Yes.tr(),
                        style: TextStyle(
                            fontSize: 16,
                            color: themenotifier.isDark ?Colors.black : color.white,
                            fontFamily: "Poppins"),
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
            resizeToAvoidBottomInset: false,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: themenotifier.isDark ? Colors.black : color.primarycolor,
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.topRight,
                          // decoration: BoxDecoration(color: color.primarycolor),
                          height: 4.h,
                          margin: EdgeInsets.all(5.w),
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Homepage()),
                              // );
                            },
                            // child: Text(
                            //   LocaleKeys.Skip_continue.tr(),
                            //   style: TextStyle(
                            //       fontFamily: 'Poppins',
                            //       color: color.white,
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 13.sp),
                            // ),
                          )),
                      Image.asset("Assets/Icons/ic_logo.png",height: 20.h,width: 50.w,),
                      Card(
                        margin: EdgeInsets.all(5.w),
                        color: color.white,
                        elevation: 3,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 4.5.w, top: 3.5.h, bottom: 1.h),
                              child: Text(
                                LocaleKeys.Login.tr(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins_Bold',color: themenotifier.isDark ? Colors.black : color.primarycolor),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                left: 4.5.w,
                              ),
                              child: Text(
                                LocaleKeys.Loginst.tr(),
                                // LocaleKeys.Signin_to_your_account,
                                style: TextStyle(fontSize: 12.sp, fontFamily: 'Poppins',
                                  color: Colors.black
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 2.5.h, left: 4.w, right: 4.w),
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) => Validators.validateEmail(value!),
                                    cursorColor: Colors.grey,
                                    controller: Email,style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        hintText: LocaleKeys.Email.tr(),
                                        border: OutlineInputBorder(),
                                        hintStyle: TextStyle(color: Colors.grey ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),
                                          borderSide:  BorderSide(color:themenotifier.isDark ? Colors.black : color.primarycolor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),
                                          borderSide: BorderSide(color: themenotifier.isDark ? Colors.black : color.primarycolor),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  TextFormField(
                                    validator: (value) => Validators.validatePassword(value!),
                                    cursorColor: Colors.grey,
                                    controller: password,style: TextStyle(color:  Colors.black ),
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                            icon: Icon(
                                              _obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.grey,
                                            )),
                                        hintText: LocaleKeys.Password.tr(),
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),
                                          borderSide:  BorderSide(color: themenotifier.isDark ? Colors.black : color.primarycolor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),
                                          borderSide:  BorderSide(color:themenotifier.isDark ? Colors.black : color.primarycolor),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(right: 4.w, top: 1.5.h),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Forgotpassword()),
                                  );
                                },
                                child: Text(
                                  LocaleKeys.Forgot_Password.tr(),
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semiBold',
                                      fontSize: 10.5.sp,color: themenotifier.isDark ? Colors.black : color.primarycolor),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formkey.currentState!.validate()) {
                                  _loginAPI();
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 2.5.h,bottom: 2.5.h, left: 4.w, right: 4.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: themenotifier.isDark ? Colors.black : color.primarycolor,
                                ),
                                height: 6.h,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    LocaleKeys.Login.tr(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins_Bold',
                                        color: Colors.white,
                                        fontSize: fontsize.Buttonfontsize),
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            /*Form(
            key: _formkey,
            child: Container(
              margin: EdgeInsets.only(
                left: 4.w,
                top: 3.h,
                right: 4.w,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      LocaleKeys.Login.tr(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'Poppins_Bold',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        LocaleKeys.Sign_in_to_your_account.tr(),
                        style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      )),
                  SizedBox(
                    height: 4.h,
                  ),
                  TextFormField(
                    validator: (value) => Validators.validateEmail(value!),
                    cursorColor: Colors.grey,
                    controller: Email,
                    decoration: InputDecoration(
                        hintText: LocaleKeys.Email.tr(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(color: Colors.grey),
                        )),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  TextFormField(
                    validator: (value) => Validators.validatePassword(value!),
                    cursorColor: Colors.grey,
                    controller: password,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            )),
                        hintText: LocaleKeys.Password.tr(),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(color: Colors.grey),
                        )),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Forgotpassword()),
                            );
                          },
                          child: Text(
                            LocaleKeys.Forgot_Password_.tr(),
                            style: TextStyle(
                                fontFamily: 'Poppins_semibold', fontSize: 16),
                          ))),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        _loginAPI();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: color.green,
                      ),
                      height: 6.h,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          LocaleKeys.Login.tr(),
                          style: TextStyle(
                              fontFamily: 'Poppins_Bold',
                              color: Colors.white,
                              fontSize: fontsize.Buttonfontsize),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )*/
          ),
        ),
      );
    },);
  }
}
