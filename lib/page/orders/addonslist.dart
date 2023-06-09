// ignore_for_file: non_constant_identifier_names, unused_element

import 'package:deliveryboy/global%20class/allformater.dart';
import 'package:deliveryboy/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

modelsheet(context, String addones, String price, currency, currency_position) {
  List<String> addonslist = addones.toString().split(",");
  List<String> priceList = price.toString().split(",");
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, value, child) {
          return SizedBox(
            height: 90.h,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 4.h,
                    child: Center(
                      child: Text(
                        LocaleKeys.Selected_Add_ons.tr(),
                        style: TextStyle(
                          fontFamily: "Poppins_bold",
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h * addonslist.length,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                    ),
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: addonslist.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 0.2.h,
                          ),
                          Text(
                            addonslist[index],
                            style: TextStyle(
                              fontFamily: "Poppins_semibold",
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(
                            height: 0.2.h,
                          ),
                          Text(
                            currency_position == "1"
                                ? "$currency${numberFormat.format(double.parse(priceList[index].toString()))}"
                                : "${numberFormat.format(double.parse(priceList[index].toString()))}$currency",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 11.sp,
                            ),
                          ),
                          const Divider(
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 0.2.h,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
