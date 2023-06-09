// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_import, non_constant_identifier_names, use_build_context_synchronously,

import 'dart:io';

import 'package:deliveryboy/config/api/api.dart';
import 'package:deliveryboy/model/loginmodel.dart';
import 'package:deliveryboy/page/authentication/login.dart';
import 'package:deliveryboy/page/settings/profile.dart';
import 'package:deliveryboy/Widget/Loder.dart';
import 'package:deliveryboy/Widget/showdialog.dart';
import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/global%20class/height.dart';
import 'package:deliveryboy/global%20class/prefsname.dart';
import 'package:deliveryboy/theme/Thememodel.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  String? username;
  String? userid;
  String? useremail;
  String? usermobile;
  String userprofileURl = "";
  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Phoneno = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String imagepath = "";
  loginModel? editprofiledata;

  imagePickerOption() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            Column(
              children: [
                SizedBox(
                  width: 100.w,
                  height: 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.camera);
                          imagepath = photo!.path;

                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 120,
                          width: 125,
                          child: Column(
                            children: const [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Icon(Icons.camera_alt, size: 60),
                              ),
                              Text(
                                "Camara",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'poppins'),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.gallery);
                          imagepath = photo!.path;

                          setState(() {});

                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 120,
                          width: 125,
                          child: Column(
                            children: const [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Icon(Icons.photo, size: 60),
                              ),
                              Text(
                                "Photos",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'poppins'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString(UD_user_id).toString();
    username = prefs.getString(UD_user_name).toString();
    useremail = prefs.getString(UD_user_email).toString();
    usermobile = prefs.getString(UD_user_mobile).toString();
    userprofileURl = prefs.getString(UD_user_profile).toString();

    setState(() {
      Name.value = TextEditingValue(text: username.toString());
      Email.value = TextEditingValue(text: useremail.toString());
      Phoneno.value = TextEditingValue(text: usermobile.toString());
    });
  }

  EditprofileAPI() async {
    try {
      var formdata = FormData.fromMap({
        "driver_id": userid,
        "name": Name.text.toString(),
        "image": imagepath.isNotEmpty
            ? await MultipartFile.fromFile(imagepath, filename: imagepath.split("/").last)
            : userprofileURl,
      });

      loader.showLoading();

      var response = await Dio().post(defaultapi.appurl + Postapi.drivereditprofile, data: formdata);
      var finallist = await response.data;
      editprofiledata = loginModel.fromJson(finallist);
      print(editprofiledata);
      loader.hideLoading();

      if (editprofiledata!.status == 1) {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(UD_user_name, Name.text.toString());
        // prefs.setString(UD_user_profile,editprofiledata!.data!.profileImage.toString());
        print("object :: $imagepath");
        setState(() {});

        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));
      } else {
        showdialog.showErroDialog(description: editprofiledata!.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Thememodel themenotifier, child) {
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
            LocaleKeys.Editprofile.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp,color: color.primarycolor),
          ),
          centerTitle: true,
          leadingWidth: 40,
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 2.h)),
            Stack(children: [
              InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 15.h,
                    width: 15.h,
                    child: ClipOval(
                      child: imagepath.isNotEmpty
                          ? Image.file(
                        File(imagepath),
                        fit: BoxFit.fill,
                      )
                          : Image(
                        image: NetworkImage(userprofileURl.toString()),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                      height: 6.h,
                      width: 11.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themenotifier.isDark ? Colors.black : color.white,
                      ),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.photo_camera),
                        onPressed: () {
                          imagePickerOption();
                        },
                      ))),
            ]),
            SizedBox(height: 4.h),
            Container(
                margin: EdgeInsets.only(top: 1.3.h, left: 4.w, right: 4.w),
                child: Column(
                  children: [
                    TextField(
                      cursorColor: Colors.grey,
                      controller: Name,
                      decoration: InputDecoration(
                          hintText: LocaleKeys.Name.tr(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.5),
                            borderSide:  BorderSide(color: color.primarycolor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.5),
                            borderSide:  BorderSide(color:color.primarycolor),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    TextField(
                      readOnly: true,
                      controller: Email,
                      decoration: InputDecoration(
                          hintText: LocaleKeys.Email.tr(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.5),
                            borderSide:  BorderSide(color: color.primarycolor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.5),
                            borderSide:  BorderSide(color:color.primarycolor),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    TextField(
                      readOnly: true,
                      controller: Phoneno,
                      decoration: InputDecoration(
                          hintText: LocaleKeys.Phoneno.tr(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.5),
                            borderSide:  BorderSide(color: color.primarycolor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.5),
                            borderSide:  BorderSide(color: color.primarycolor),
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
            } else {
              EditprofileAPI();
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
              color: color.primarycolor,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: Text(
                LocaleKeys.reset.tr(),
                style: TextStyle(
                    fontFamily: 'Poppins_semiBold',
                    color: Colors.white,
                    fontSize: fontsize.Buttonfontsize),
              ),
            ),
          ),
        ),
      );
    },);
  }
}
