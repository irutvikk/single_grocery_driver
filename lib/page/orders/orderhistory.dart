// ignore_for_file: prefer_const_constructors, file_names, unnecessary_import, unused_local_variable, avoid_print

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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Orderhistory extends StatefulWidget {
  const Orderhistory({Key? key}) : super(key: key);

  @override
  State<Orderhistory> createState() => _OrderhistoryState();
}

class _OrderhistoryState extends State<Orderhistory> {
  ongoing_orderModel? orderdata;
  String? currency;
  int? currencypostion;
  orderhistoryAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString(UD_user_id)!;
    currency = prefs.getString(APPcurrency)!;
    currencypostion = prefs.getInt(APPcurrency_position)!;

    var map = {
      "driver_id": userid,
    };

    var response =
        await Dio().post(defaultapi.appurl + Postapi.driverorder, data: map);

    orderdata = ongoing_orderModel.fromJson(response.data);
    if (orderdata!.status == 1) {
      return orderdata;
    } else {
      showdialog.showErroDialog(description: orderdata!.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
      future: orderhistoryAPI(),
      builder: (context, snapshot) {
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
            title: Text(
              LocaleKeys.Order_History.tr(),
              style: TextStyle(fontFamily: 'Poppins_semibold', fontSize: 12.sp,color: color.primarycolor),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            margin: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w),
            child: orderdata!.data!.isEmpty
                ? Center(
                    child: Text(
                      LocaleKeys.No_data_found.tr(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.sp,
                        color: color.primarycolor
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: orderdata!.data!.length,
                    itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(top: 1.2.h,),
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
                                        orderdata!.data![index].id.toString())),
                              );
                            },
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "#${orderdata!.data![index].orderNumber.toString()}",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Poppins_semibold'),
                                      ),
                                      Spacer(),
                                      if (orderdata!.data![index].status == "4") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: color.green,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: EdgeInsets.all(6),
                                          height: 4.h,
                                          child: Center(
                                            child: Text(
                                                LocaleKeys.On_the_way.tr(),
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white)),
                                          ),
                                        )
                                      ] else if (orderdata!
                                              .data![index].status ==
                                          "5") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: color.primarycolor,
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
                                      ] else if (orderdata!
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
                                      ] else if (orderdata!
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
                                    height: 0.8.sp,
                                    color: color.primarycolor,
                                  ),
                                  Row(
                                    children: [
                                      Text(LocaleKeys.Payment_Type.tr(),
                                          style: TextStyle(
                                              fontSize: 9.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey)),
                                      if (orderdata!
                                              .data![index].transactionType ==
                                          "1") ...[
                                        Text(LocaleKeys.Cash.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ] else if (orderdata!
                                              .data![index].transactionType ==
                                          "2") ...[
                                        Text(LocaleKeys.Wallet.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ] else if (orderdata!
                                              .data![index].transactionType ==
                                          "3") ...[
                                        Text(LocaleKeys.Razorpay.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ] else if (orderdata!
                                              .data![index].transactionType ==
                                          "4") ...[
                                        Text(LocaleKeys.Stripe.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ] else if (orderdata!
                                              .data![index].transactionType ==
                                          "5") ...[
                                        Text(LocaleKeys.FlutterWave.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ] else if (orderdata!
                                              .data![index].transactionType ==
                                          "6") ...[
                                        Text(LocaleKeys.Paystack.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ],
                                      Spacer(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          getFormatedDate(
                                              orderdata!.data![index].date),
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: 'Poppins',
                                          )),
                                      Text(
                                          currencypostion == "1"
                                              ? "$currency${numberFormat.format(double.parse(orderdata!.data![index].grandTotal))}"
                                              : "${numberFormat.format(double.parse(orderdata!.data![index].grandTotal))}$currency",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontFamily: 'Poppins_semibold',
                                          )),
                                    ],
                                  )
                                ]),
                          ),
                        )),
          ),
        );
      },
    ));
  }
}
