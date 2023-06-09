// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, file_names, use_build_context_synchronously

import 'package:deliveryboy/Page/settings/editprofile.dart';
import 'package:deliveryboy/page/settings/changepassword.dart';
import 'package:deliveryboy/page/authentication/login.dart';
import 'package:deliveryboy/page/settings/aboutus.dart';
import 'package:deliveryboy/page/settings/privacypolicy.dart';
import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/global%20class/height.dart';
import 'package:deliveryboy/global%20class/prefsname.dart';
import 'package:deliveryboy/theme/Thememodel.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    initdata();
  }

  String userid = "";
  String username = "";
  String userprofile = "";
  String useremail = "";

  initdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(UD_user_name).toString();
      useremail = prefs.getString(UD_user_email)!;
      userprofile = prefs.getString(UD_user_profile)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, Thememodel themenotifier, child) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 21.h,margin: EdgeInsets.only(left: 1.w,right: 1.w,top: 1.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: themenotifier.isDark ?Colors.white : color.primarycolor,
                      borderRadius: BorderRadius.circular(5.w)
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 3.h),
                              child: Text(
                                LocaleKeys.my_profile.tr(),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: themenotifier.isDark
                                        ? Colors.black
                                        : Colors.white,
                                    fontFamily: 'Poppins_semibold'),
                              ),
                            ),
                            Spacer(),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: themenotifier.isDark
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                height: 5.h,
                                width: 5.h,
                                margin: EdgeInsets.only(top: 3.5.h),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Editprofile()));
                                    },
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'Assets/svgicon/Edit.svg',
                                        height: height.settingiconheight,
                                        color: themenotifier.isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ))),
                            Padding(
                              padding: EdgeInsets.only(right: 4.8.w),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 9.h,
                              width: 9.h,
                              margin: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 1.3.h),
                              child: ClipOval(
                                child: Image.network(
                                  userprofile,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 3.w,
                                  ),
                                  child: Text(
                                    username,
                                    style: TextStyle(
                                        color: themenotifier.isDark
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 13.sp,
                                        fontFamily: 'Poppins_semibold'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 3.w,
                                  ),
                                  child: Text(
                                    useremail,
                                    style: TextStyle(
                                        color: themenotifier.isDark
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 10.5.sp,
                                        fontFamily: 'Poppin'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: 1.5.h, left: 4.w, right: 4.w),
                            height: height.settingsheight,
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.Settings.tr(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins_semibold',
                                    color: themenotifier.isDark
                                        ? Colors.white
                                        : color.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: height.settingsheight,
                            margin: EdgeInsets.only(left: 4.w, right: 4.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Changepassword()),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'Assets/svgicon/Lock.svg',
                                      height: height.settingiconheight,
                                      color: themenotifier.isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 3.8.w, right: 3.8.w),
                                      child: Text(
                                        LocaleKeys.Change_Password.tr(),
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 13.sp,
                                      color: Colors.grey.shade300,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4.w, right: 4.w),
                            height: 0.5.sp,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        height: 30.h,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 1.5.h, bottom: 1.5.h),
                                              child: Text(
                                                  LocaleKeys
                                                          .Select_Application_Layout
                                                      .tr(),
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Poppins')),
                                            ),
                                            Container(
                                              height: 0.5.sp,
                                              width: double.infinity,
                                              color: Colors.grey,
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await context
                                                    .setLocale(Locale('en'));
                                                Navigator.of(context).pop();
                                                Phoenix.rebirth(context);
                                              },
                                              child: Text(
                                                LocaleKeys.LTR.tr(),
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins_Bold'),
                                              ),
                                            ),
                                            Container(
                                              height: 0.5.sp,
                                              width: double.infinity,
                                              color: Colors.grey,
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await context
                                                    .setLocale(Locale('ar'));
                                                Navigator.of(context).pop();
                                                Phoenix.rebirth(context);
                                              },
                                              child: Text(
                                                LocaleKeys.RTL.tr(),
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins_Bold'),
                                              ),
                                            ),
                                            Container(
                                              height: 0.5.sp,
                                              width: double.infinity,
                                              color: Colors.grey,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                LocaleKeys.Cancel.tr(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins_Bold',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                  });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 4.w, right: 4.w),
                              width: double.infinity,
                              height: height.settingsheight,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'Assets/svgicon/Changelayout.svg',
                                    height: height.settingiconheight,
                                    color: themenotifier.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 3.8.w, right: 3.8.w),
                                    child: Text(
                                      LocaleKeys.Change_Layout.tr(),
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 13.sp,
                                    color: Colors.grey.shade300,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4.w, right: 4.w),
                            height: 0.5.sp,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => privacypolicy());
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 4.w, right: 4.w),
                              width: double.infinity,
                              height: height.settingsheight,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'Assets/svgicon/Privacypolicy.svg',
                                    height: height.settingiconheight,
                                    color: themenotifier.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 3.8.w, right: 3.8.w),
                                    child: Text(
                                      LocaleKeys.Privacy_Policy.tr(),
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 13.sp,
                                    color: Colors.grey.shade300,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4.w, right: 4.w),
                            height: 0.5.sp,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => aboutus());
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 4.w, right: 4.w),
                              width: double.infinity,
                              height: height.settingsheight,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'Assets/svgicon/Aboutus.svg',
                                    height: height.settingiconheight,
                                    color: themenotifier.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 3.8.w,
                                      right: 3.8.w,
                                    ),
                                    child: Text(
                                      LocaleKeys.About_Us.tr(),
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 13.sp,
                                    color: Colors.grey.shade300,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4.w, right: 4.w),
                            height: 0.5.sp,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(left: 4.w, right: 4.w),
                              width: double.infinity,
                              height: height.settingsheight,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'Assets/Icons/darkmode.png',
                                    height: height.settingiconheight,
                                    color: themenotifier.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 3.8.w,
                                      right: 3.8.w,
                                    ),
                                    child: Text(
                                      LocaleKeys.Darkmode.tr(),
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  Spacer(),
                                  Switch(
                                      activeColor: Colors.white,
                                      value:
                                          themenotifier.isDark ? true : false,
                                      onChanged: (value) {
                                        themenotifier.isDark
                                            ? themenotifier.isdark = false
                                            : themenotifier.isdark = true;
                                      }),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4.w, right: 4.w),
                            height: 0.5.sp,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        LocaleKeys.Grocery_Driver.tr(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Poppins_semibold"),
                                      ),
                                      content: Text(
                                        LocaleKeys
                                                .Are_you_sure_to_exit_from_this_app
                                            .tr(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Poppins"),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: color.primarycolor,
                                          ),
                                          child: Text(
                                            LocaleKeys.Logout.tr(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: color.white,
                                                fontFamily: "Poppins"),
                                          ),
                                          onPressed: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.clear();
                                            prefs.remove(UD_user_id);
                                            prefs.remove(UD_user_name);
                                            prefs.remove(UD_user_email);
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (c) =>
                                                            Login()),
                                                    (r) => false);
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: color.primarycolor,
                                          ),
                                          child: Text(
                                            LocaleKeys.Cancel.tr(),
                                            style: TextStyle(
                                                color: color.white,
                                                fontSize: 16,
                                                fontFamily: "Poppins"),
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 4.w, right: 4.w),
                              width: double.infinity,
                              height: height.settingsheight,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'Assets/svgicon/Logout.svg',
                                    height: height.settingiconheight,
                                    color: themenotifier.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 3.8.w, right: 3.8.w),
                                    child: Text(
                                      LocaleKeys.Logout.tr(),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 13.sp,
                                    color: Colors.grey.shade300,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4.w, right: 4.w),
                            height: 0.5.sp,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
