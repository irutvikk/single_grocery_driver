// ignore_for_file: prefer_const_constructors, non_constant_identifier_names,  unused_local_variable, file_names

import 'package:deliveryboy/model/ongoingorder.dart';
import 'package:deliveryboy/page/orders/orderdetails.dart';
import 'package:deliveryboy/Widget/showdialog.dart';
import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/global%20class/allformater.dart';
import 'package:deliveryboy/global%20class/prefsname.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:deliveryboy/config/api/API.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../theme/Thememodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ongoing_orderModel? ongoingdata;
  String? currency;
  int? currencyposition;

  OngoingorderAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString(UD_user_id)!;
    var map = {
      "driver_id": userid,
    };

    var response = await Dio()
        .post(defaultapi.appurl + Postapi.driverongoingorder, data: map);
    ongoingdata = ongoing_orderModel.fromJson(response.data);
    if (ongoingdata!.status == 1) {
      prefs.setString(ABOUT_US, ongoingdata!.appdata!.aboutContent);
      prefs.setString(APPcurrency, ongoingdata!.appdata!.currency);
      prefs.setInt(
          APPcurrency_position, ongoingdata!.appdata!.currencyPosition);
      currency = prefs.getString(APPcurrency);
      currencyposition = prefs.getInt(APPcurrency_position);
      return ongoingdata;
    } else {
      showdialog.showErroDialog(description: ongoingdata!.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Thememodel themenotifier, child) {
      return SafeArea(
          child: FutureBuilder(
        future: OngoingorderAPI(),
        builder: (context, snapshot) {
          print(snapshot);
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: color.primarycolor,
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleSpacing: 4.w,
              title: Text(
                LocaleKeys.Dashboard.tr(),
                style: TextStyle(fontFamily: 'Poppins_bold', fontSize: 16.sp,color: color.primarycolor),
              ),
              automaticallyImplyLeading: false,
            ),
            body: Container(
              margin: EdgeInsets.only(
                top: 1.h,
                left: 4.w,
                right: 4.w,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 1.h, left: 2.w, right: 2.w, bottom: 0.5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              width: 1,
                              color: color.primarycolor,
                            )),
                        height: 15.h,
                        width: 44.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'Assets/svgicon/Home.svg',
                              height: 22.sp,
                              color: themenotifier.isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            Text(
                              ongoingdata!.completedOrder.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins_bold', fontSize: 13.sp,color: Colors.black),
                            ),
                            Text(
                              LocaleKeys.Total_Orders.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 10.5.sp,color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 1.h, left: 2.w, right: 2.w, bottom: 0.5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              width: 1,
                              color: color.primarycolor,
                            )),
                        height: 15.h,
                        width: 44.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'Assets/svgicon/Home.svg',
                              height: 23.sp,
                              color: themenotifier.isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            Text(
                              ongoingdata!.ongoingOrder.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins_bold', fontSize: 13.sp,color: Colors.black),
                            ),
                            Text(
                              LocaleKeys.Ongoing_Orders.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 10.5.sp,color: Colors.black),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      LocaleKeys.Ongoing_Orders.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins_semibold',
                        fontSize: 17.sp,
                        color: color.primarycolor
                      ),
                    ),
                  ),
                  if (ongoingdata!.data!.isEmpty) ...[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 25.h,
                      ),
                      child: Center(
                        child: Text(
                          LocaleKeys.No_data_found.tr(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            color: color.primarycolor
                          ),
                        ),
                      ),
                    )
                  ],
                  Expanded(
                    child: ListView.builder(
                        itemCount: ongoingdata!.data!.length,
                        itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(
                                top: 1.2.h,
                              ),
                              padding: EdgeInsets.all(1.h),
                              width: double.infinity,
                              height: 15.5.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: color.primarycolor),
                                  borderRadius: BorderRadius.circular(6)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => orderdetails(
                                              ongoingdata!.data![index].id
                                                  .toString(),
                                            )),
                                  );
                                },
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "#${ongoingdata!.data![index].orderNumber}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Poppins_semibold'),
                                          ),
                                          Spacer(),
                                          if (ongoingdata!
                                                  .data![index].status ==
                                              "4") ...[
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: color.primarycolor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              padding: EdgeInsets.all(6),
                                              height: 4.h,
                                              child: Center(
                                                child: Text(
                                                    LocaleKeys.On_the_way.tr(),
                                                    style: TextStyle(
                                                        fontSize: 9.sp,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      fontWeight: FontWeight.bold
                                                    )),
                                              ),
                                            )
                                          ] else if (ongoingdata!
                                                  .data![index].status ==
                                              "5") ...[
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: color.status5,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              padding: EdgeInsets.all(6),
                                              height: 4.h,
                                              child: Center(
                                                child: Text(
                                                    LocaleKeys.Completed.tr(),
                                                    style: TextStyle(
                                                        fontSize: 8.sp,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white)),
                                              ),
                                            )
                                          ] else if (ongoingdata!
                                                  .data![index].status ==
                                              "6") ...[
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: color.status67,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              padding: EdgeInsets.all(6),
                                              height: 4.h,
                                              child: Center(
                                                child: Text(
                                                    LocaleKeys.Cancelled.tr(),
                                                    style: TextStyle(
                                                        fontSize: 8.sp,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white)),
                                              ),
                                            )
                                          ] else if (ongoingdata!
                                                  .data![index].status ==
                                              "7") ...[
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: color.status67,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              padding: EdgeInsets.all(6),
                                              height: 4.h,
                                              child: Center(
                                                child: Text(
                                                    LocaleKeys.Cancelled.tr(),
                                                    style: TextStyle(
                                                        fontSize: 8.sp,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white)),
                                              ),
                                            )
                                          ]
                                        ],
                                      ),
                                      Container(
                                        height: 1.sp,
                                        color: color.primarycolor,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            LocaleKeys.Payment_Type.tr(),
                                            style: TextStyle(
                                              fontSize: 9.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey,
                                            ),
                                          ),
                                          if (ongoingdata!.data![index]
                                                  .transactionType ==
                                              "1") ...[
                                            Text(LocaleKeys.Cash.tr(),
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.grey)),
                                          ] else if (ongoingdata!.data![index]
                                                  .transactionType ==
                                              "2") ...[
                                            Text(LocaleKeys.Wallet.tr(),
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.grey)),
                                          ] else if (ongoingdata!.data![index]
                                                  .transactionType ==
                                              "3") ...[
                                            Text(LocaleKeys.Razorpay.tr(),
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.grey)),
                                          ] else if (ongoingdata!.data![index]
                                                  .transactionType ==
                                              "4") ...[
                                            Text(LocaleKeys.Stripe.tr(),
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.grey)),
                                          ] else if (ongoingdata!.data![index]
                                                  .transactionType ==
                                              "5") ...[
                                            Text(LocaleKeys.FlutterWave.tr(),
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.grey)),
                                          ] else if (ongoingdata!.data![index]
                                                  .transactionType ==
                                              "6") ...[
                                            Text(
                                              LocaleKeys.Paystack.tr(),
                                              style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              getFormatedDate(ongoingdata!
                                                  .data![index].date),
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: 'Poppins',
                                              )),
                                          Text(
                                              currencyposition == "1"
                                                  ? "$currency${numberFormat.format(double.parse(ongoingdata!.data![index].grandTotal))}"
                                                  : "${numberFormat.format(double.parse(ongoingdata!.data![index].grandTotal))}$currency",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontFamily: 'Poppins_semibold',
                                              )),
                                        ],
                                      )
                                    ]),
                              ),
                            )),
                  )
                ],
              ),
            ),
          );
        },
      ));
    });
  }
}
