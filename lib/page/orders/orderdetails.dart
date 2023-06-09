// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable, camel_case_types, use_key_in_widget_constructors, non_constant_identifier_names, sized_box_for_whitespace

import 'package:deliveryboy/global%20class/icons.dart';
import 'package:deliveryboy/model/loginmodel.dart';
import 'package:deliveryboy/model/orderdetailsmodel.dart';
import 'package:deliveryboy/Widget/Loder.dart';
import 'package:deliveryboy/Widget/showdialog.dart';
import 'package:deliveryboy/global%20class/color.dart';
import 'package:deliveryboy/global%20class/allformater.dart';
import 'package:deliveryboy/global%20class/height.dart';
import 'package:deliveryboy/global%20class/prefsname.dart';
import 'package:deliveryboy/page/orders/addonslist.dart';
import 'package:deliveryboy/theme/Thememodel.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:deliveryboy/config/api/API.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart' hide Trans;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class orderdetails extends StatefulWidget {
  String? orderid;
  // const orderinfo({Key? key}) : super(key: key);

  @override
  State<orderdetails> createState() => _orderdetailsState();
  orderdetails([this.orderid]);
}

class _orderdetailsState extends State<orderdetails> {
  orderdetailMODEL? orderdata;
  String? currency;
  int? currencyposition;

  OrderdetailAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString(UD_user_id)!;
    currency = prefs.getString(APPcurrency)!;
    currencyposition = prefs.getInt(APPcurrency_position)!;

    try {
      var map = {
        "order_id": widget.orderid,
        "user_id": userid,
      };

      var response = await Dio()
          .post(defaultapi.appurl + Postapi.getorderdetails, data: map);
      orderdata = orderdetailMODEL.fromJson(response.data);
      if (orderdata!.status == 1) {
        return orderdata;
      } else {
        showdialog.showErroDialog(description: orderdata!.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, Thememodel themenotifier, child) {
        return SafeArea(
          child: FutureBuilder(
            future: OrderdetailAPI(),
            builder: (context, snapshot) {
              print(snapshot);
              if (!snapshot.hasData) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: color.primarycolor,
                    ),
                  ),
                );
              }
              return Scaffold(
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
                    LocaleKeys.Order_Details.tr(),
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontFamily: 'Poppins_semibold', fontSize: 15.sp,color: color.primarycolor),
                  ),
                  centerTitle: true,
                  leadingWidth: 40,
                ),
                body: Container(
                  margin: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(1.h),
                            width: double.infinity,
                            height: 16.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: color.primarycolor),
                                borderRadius: BorderRadius.circular(6)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "#${orderdata!.summery!.orderNumber.toString()}",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Poppins_bold'),
                                      ),
                                      Spacer(),
                                      if (orderdata!.summery!.status == "4") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: color.primarycolor,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          padding: EdgeInsets.all(6),
                                          height: 4.h,
                                          child: Center(
                                            child: Text(LocaleKeys.On_the_way.tr(),
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        )
                                      ] else if (orderdata!.summery!.status ==
                                          "5") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: color.primarycolor,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          padding: EdgeInsets.all(6),
                                          height: 4.h,
                                          child: Center(
                                            child: Text(LocaleKeys.Completed.tr(),
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white)),
                                          ),
                                        )
                                      ] else if (orderdata!.summery!.status ==
                                          "6") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: color.status67,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          padding: EdgeInsets.all(6),
                                          height: 4.h,
                                          child: Center(
                                            child: Text(LocaleKeys.Cancelled.tr(),
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white)),
                                          ),
                                        )
                                      ] else if (orderdata!.summery!.status ==
                                          "7") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: color.status67,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          padding: EdgeInsets.all(6),
                                          height: 4.h,
                                          child: Center(
                                            child: Text(LocaleKeys.Cancelled.tr(),
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
                                    margin:
                                    EdgeInsets.only(top: 0.8.h, bottom: 0.8.h),
                                    height: 0.5.sp,
                                    color: color.primarycolor,
                                  ),
                                  Row(
                                    children: [
                                      Text(LocaleKeys.Payment_Type.tr(),
                                          style: TextStyle(
                                              fontSize: 9.sp,
                                              fontFamily: 'Poppins',
                                              color: Colors.grey)),
                                      if (orderdata!.summery!.transactionType ==
                                          "1") ...[
                                        Text(LocaleKeys.Cash.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ] else if (orderdata!
                                          .summery!.transactionType ==
                                          "2") ...[
                                        Text(LocaleKeys.Wallet.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ] else if (orderdata!
                                          .summery!.transactionType ==
                                          "3") ...[
                                        Text(LocaleKeys.Razorpay.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ] else if (orderdata!
                                          .summery!.transactionType ==
                                          "4") ...[
                                        Text(LocaleKeys.Stripe.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ] else if (orderdata!
                                          .summery!.transactionType ==
                                          "5") ...[
                                        Text(LocaleKeys.FlutterWave.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ] else if (orderdata!
                                          .summery!.transactionType ==
                                          "6") ...[
                                        Text(LocaleKeys.Paystack.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ],
                                      Spacer(),
                                      if (orderdata!.summery!.orderType == "1") ...[
                                        Text(LocaleKeys.Delivery.tr(),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey)),
                                      ]
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          getFormatedDate(orderdata!.summery!.date),
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontFamily: 'Poppins',
                                          )),
                                      Text(
                                          currencyposition == "1"
                                              ? "$currency${numberFormat.format(double.parse(orderdata!.summery!.grandTotal.toString()))}"
                                              : "${numberFormat.format(double.parse(orderdata!.summery!.grandTotal.toString()))}$currency",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Poppins_bold',
                                          )),
                                    ],
                                  )
                                ])),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.User_information.tr(),
                              style: TextStyle(
                                  fontFamily: 'Poppins_semibold',
                                  fontSize: 12.5.sp,
                                  color: color.primarycolor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 5.h,
                              width: 10.w,
                              child: ClipOval(
                                child: Image.network(
                                  orderdata!.userInfo!.profileImage.toString(),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderdata!.userInfo!.name.toString(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 10.5.sp),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                FlutterPhoneDirectCaller.callNumber(
                                    orderdata!.userInfo!.mobile!);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: color.primarycolor,
                                      borderRadius: BorderRadius.circular(7)),
                                  height: 3.8.h,
                                  width: 3.8.h,
                                  child: Center(
                                    child: Icon(
                                      Icons.phone_in_talk_outlined,
                                      color: Colors.white,
                                      size: 13.sp,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.Delivery_address.tr(),
                              style: TextStyle(
                                  fontFamily: 'Poppins_semibold',
                                  fontSize: 12.5.sp,
                                  color: color.primarycolor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage(
                                'Assets/Icons/address.png',
                              ),
                              height: 16.sp,color: themenotifier.isDark ? Colors.white : Colors.black,),
                            SizedBox(
                              width: 2.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  orderdata!.summery!.address.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 10.sp),
                                )
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                openmap(double.parse(orderdata!.summery!.lat),
                                    double.parse(orderdata!.summery!.lang));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: themenotifier.isDark ? color.primarycolor : color.black,
                                      borderRadius: BorderRadius.circular(7)),
                                  height: 3.8.h,
                                  width: 3.8.h,
                                  child: Center(
                                    child: Image(
                                        image: AssetImage(
                                          'Assets/Icons/address.png',
                                        ),
                                        color: Colors.white,
                                        height: 1.9.h),
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          height: orderdata!.data!.length * 16.h,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: orderdata!.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 1.5.h,),padding: EdgeInsets.all(1.w),
                                  height: 13.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                        color: color.primarycolor,
                                        width: 0.8.sp,
                                      )),
                                  child: Row(children: [
                                    SizedBox(
                                      width: 28.w,
                                      height: 15.5.h,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.network(
                                          orderdata!.data![index].itemImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: 2.w,
                                          left: 2.w,
                                          bottom: 0.8.h,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  if (orderdata!
                                                      .data![index].itemType ==
                                                      "1") ...[
                                                    SizedBox(
                                                      height: 2.h,
                                                      // color: Colors.black,
                                                      child: Image.asset(
                                                        Defaulticon.vegicon,
                                                      ),
                                                    ),
                                                  ] else if (orderdata!
                                                      .data![index].itemType ==
                                                      "2") ...[
                                                    SizedBox(
                                                      height: 2.h,
                                                      // color: Colors.black,
                                                      child: Image.asset(
                                                        Defaulticon.nonvegicon,
                                                      ),
                                                    ),
                                                  ],
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SizedBox(
                                                    width: 42.w,
                                                    child: Text(
                                                      orderdata!
                                                          .data![index].itemName
                                                          .toString(),
                                                      maxLines: 1,
                                                      softWrap: true,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontFamily:
                                                        'Poppins_semibold',
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                            if (orderdata!.data![index].variation ==
                                                "") ...[
                                              Expanded(
                                                child: Text(
                                                  "-",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 9.sp,
                                                    // color: Colors.grey,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                            ] else ...[
                                              Expanded(
                                                child: Text(
                                                  orderdata!.data![index].variation
                                                      .toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 9.sp,
                                                    color: Colors.grey,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                            ],
                                            if (orderdata!
                                                .data![index].addonsName ==
                                                "") ...[
                                              Expanded(
                                                child: Text(
                                                  "-",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                            ] else ...[
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    modelsheet(
                                                        context,
                                                        orderdata!.data![index]
                                                            .addonsName,
                                                        orderdata!.data![index]
                                                            .addonsPrice,
                                                        currency,
                                                        currencyposition);
                                                  },
                                                  child: Text(
                                                    "${LocaleKeys.Add_ons.tr()}>>",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 9.sp,
                                                      color: Colors.grey,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            Row(children: [
                                              Text(
                                                "${LocaleKeys.QTY.tr()} ${orderdata!.data![index].qty.toString()}",
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                              Spacer(),
                                              SizedBox(
                                                child: Text(
                                                  currencyposition == "1"
                                                      ? "$currency${(numberFormat.format(double.parse(orderdata!.data![index].totalPrice!.toString())))}"
                                                      : "${(numberFormat.format(double.parse(orderdata!.data![index].totalPrice!.toString())))}$currency",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily: 'Poppins_semibold',
                                                  ),
                                                ),
                                              ),
                                            ])
                                          ],
                                        ),
                                      ),
                                    )
                                  ]),
                                );
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1.h, left: 1.w, right: 1.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.Bill_Details.tr(),
                                style: TextStyle(
                                    fontFamily: 'Poppins_Bold', fontSize: 12.sp,color: color.primarycolor),
                              ),
                              SizedBox(
                                height: 0.8.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.Item_Total.tr(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 10.5.sp),
                                  ),
                                  Text(
                                    currencyposition == "1"
                                        ? "$currency${numberFormat.format(double.parse(orderdata!.summery!.orderTotal.toString()))}"
                                        : "${numberFormat.format(double.parse(orderdata!.summery!.orderTotal.toString()))}$currency",
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semiBold',
                                        fontSize: 10.5.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.Tax.tr(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 10.5.sp),
                                  ),
                                  Text(
                                    currencyposition == "1"
                                        ? "$currency${numberFormat.format(double.parse(orderdata!.summery!.tax.toString()))}"
                                        : "${numberFormat.format(double.parse(orderdata!.summery!.tax.toString()))}$currency",
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semiBold',
                                        fontSize: 10.5.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.Delivery_Fee.tr(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 10.5.sp),
                                  ),
                                  Text(
                                    currencyposition == "1"
                                        ? "$currency${numberFormat.format(double.parse(orderdata!.summery!.deliveryCharge.toString()))}"
                                        : "${numberFormat.format(double.parse(orderdata!.summery!.deliveryCharge.toString()))}$currency",
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semiBold',
                                        fontSize: 10.5.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.Discount_offer.tr(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 10.5.sp),
                                  ),
                                  Text(
                                    currencyposition == "1"
                                        ? "$currency${numberFormat.format(double.parse(orderdata!.summery!.discountAmount.toString()))}"
                                        : "${numberFormat.format(double.parse(orderdata!.summery!.discountAmount.toString()))}$currency",
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semiBold',
                                        fontSize: 10.5.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 0.8.h,
                              ),
                              Container(
                                height: 1.sp,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.Total_Pay.tr(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semibold',
                                        color: color.primarycolor,
                                        fontSize: 13.sp),
                                  ),
                                  Text(
                                    currencyposition == "1"
                                        ? "$currency${numberFormat.format(double.parse(orderdata!.summery!.grandTotal.toString()))}"
                                        : "${numberFormat.format(double.parse(orderdata!.summery!.grandTotal.toString()))}$currency",
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semiBold',
                                        color: color.primarycolor,
                                        fontSize: 13.sp),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              SizedBox(
                                height: 1.h,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomSheet: orderdata!.summery!.status == "4"
                    ? Container(
                  margin: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                  decoration: BoxDecoration(
                      color: color.primarycolor,
                      borderRadius: BorderRadius.circular(6.5)),
                  height: 6.h,
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      LocaleKeys.Delivered.tr(),
                      style: TextStyle(
                          fontFamily: 'Poppins_Bold',
                          color: Colors.white,
                          fontSize: fontsize.Buttonfontsize),
                    ),
                    onPressed: () {
                      deliverdAPI();
                    },
                  ),
                )
                    : null,
              );
            },
          ),
        );
      },
    );
  }

  deliverdAPI() async {
    loader.showLoading();
    var map = {
      "order_id": widget.orderid,
    };
    var response =
        await Dio().post(defaultapi.appurl + Postapi.delivered, data: map);
    loginModel data = loginModel.fromJson(response.data);
    loader.hideLoading();
    if (data.status == 1) {
      Get.back();
    } else {
      showdialog.showErroDialog(description: data.message);
    }
  }

  openmap(double lat, double lang) async {
    String googlemapURL =
        "https://www.google.com/maps/search/?api=1&query=$lat,$lang";
    if (await canLaunchUrlString(googlemapURL)) {
      await launchUrl(Uri.parse(googlemapURL));
    } else {
      throw "could not open the map";
    }
  }
}
