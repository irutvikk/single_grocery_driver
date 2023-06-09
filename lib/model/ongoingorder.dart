// ignore_for_file: camel_case_types, prefer_collection_literals

class ongoing_orderModel {
  dynamic status;
  dynamic message;
  dynamic completedOrder;
  dynamic ongoingOrder;
  List<Data>? data;
  Appdata? appdata;

  ongoing_orderModel(
      {this.status,
      this.message,
      this.completedOrder,
      this.ongoingOrder,
      this.data,
      this.appdata});

  ongoing_orderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    completedOrder = json['completed_order'];
    ongoingOrder = json['ongoing_order'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    appdata =
        json['appdata'] != null ? Appdata.fromJson(json['appdata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['completed_order'] = completedOrder;
    data['ongoing_order'] = ongoingOrder;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (appdata != null) {
      data['appdata'] = appdata!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic orderNumber;
  dynamic status;
  dynamic transactionType;
  dynamic grandTotal;
  dynamic qty;
  dynamic date;

  Data(
      {this.id,
      this.orderNumber,
      this.status,
      this.transactionType,
      this.grandTotal,
      this.qty,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    status = json['status'];
    transactionType = json['transaction_type'];
    grandTotal = json['grand_total'];
    qty = json['qty'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['status'] = status;
    data['transaction_type'] = transactionType;
    data['grand_total'] = grandTotal;
    data['qty'] = qty;
    data['date'] = date;
    return data;
  }
}

class Appdata {
  dynamic id;
  dynamic aboutContent;
  dynamic fb;
  dynamic youtube;
  dynamic insta;
  dynamic android;
  dynamic ios;
  dynamic appBottomImage;
  dynamic mobileAppImage;
  dynamic mobileAppTitle;
  dynamic mobileAppDescription;
  dynamic copyright;
  dynamic title;
  dynamic shortTitle;
  dynamic ogTitle;
  dynamic ogDescription;
  dynamic mobile;
  dynamic email;
  dynamic address;
  dynamic currency;
  dynamic currencyPosition;
  dynamic maxOrderQty;
  dynamic minOrderAmount;
  dynamic maxOrderAmount;
  dynamic deliveryCharge;
  dynamic map;
  dynamic firebase;
  dynamic referralAmount;
  dynamic timezone;
  dynamic lat;
  dynamic lang;
  dynamic image;
  dynamic logo;
  dynamic footerLogo;
  dynamic favicon;
  dynamic ogImage;
  dynamic verification;
  dynamic currentVersion;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic appBottomImageUrl;
  dynamic isAppBottomImage;

  Appdata(
      {this.id,
      this.aboutContent,
      this.fb,
      this.youtube,
      this.insta,
      this.android,
      this.ios,
      this.appBottomImage,
      this.mobileAppImage,
      this.mobileAppTitle,
      this.mobileAppDescription,
      this.copyright,
      this.title,
      this.shortTitle,
      this.ogTitle,
      this.ogDescription,
      this.mobile,
      this.email,
      this.address,
      this.currency,
      this.currencyPosition,
      this.maxOrderQty,
      this.minOrderAmount,
      this.maxOrderAmount,
      this.deliveryCharge,
      this.map,
      this.firebase,
      this.referralAmount,
      this.timezone,
      this.lat,
      this.lang,
      this.image,
      this.logo,
      this.footerLogo,
      this.favicon,
      this.ogImage,
      this.verification,
      this.currentVersion,
      this.createdAt,
      this.updatedAt,
      this.appBottomImageUrl,
      this.isAppBottomImage});

  Appdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutContent = json['about_content'];
    fb = json['fb'];
    youtube = json['youtube'];
    insta = json['insta'];
    android = json['android'];
    ios = json['ios'];
    appBottomImage = json['app_bottom_image'];
    mobileAppImage = json['mobile_app_image'];
    mobileAppTitle = json['mobile_app_title'];
    mobileAppDescription = json['mobile_app_description'];
    copyright = json['copyright'];
    title = json['title'];
    shortTitle = json['short_title'];
    ogTitle = json['og_title'];
    ogDescription = json['og_description'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    currency = json['currency'];
    currencyPosition = json['currency_position'];
    maxOrderQty = json['max_order_qty'];
    minOrderAmount = json['min_order_amount'];
    maxOrderAmount = json['max_order_amount'];
    deliveryCharge = json['delivery_charge'];
    map = json['map'];
    firebase = json['firebase'];
    referralAmount = json['referral_amount'];
    timezone = json['timezone'];
    lat = json['lat'];
    lang = json['lang'];
    image = json['image'];
    logo = json['logo'];
    footerLogo = json['footer_logo'];
    favicon = json['favicon'];
    ogImage = json['og_image'];
    verification = json['verification'];
    currentVersion = json['current_version'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    appBottomImageUrl = json['app_bottom_image_url'];
    isAppBottomImage = json['is_app_bottom_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['about_content'] = aboutContent;
    data['fb'] = fb;
    data['youtube'] = youtube;
    data['insta'] = insta;
    data['android'] = android;
    data['ios'] = ios;
    data['app_bottom_image'] = appBottomImage;
    data['mobile_app_image'] = mobileAppImage;
    data['mobile_app_title'] = mobileAppTitle;
    data['mobile_app_description'] = mobileAppDescription;
    data['copyright'] = copyright;
    data['title'] = title;
    data['short_title'] = shortTitle;
    data['og_title'] = ogTitle;
    data['og_description'] = ogDescription;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['currency'] = currency;
    data['currency_position'] = currencyPosition;
    data['max_order_qty'] = maxOrderQty;
    data['min_order_amount'] = minOrderAmount;
    data['max_order_amount'] = maxOrderAmount;
    data['delivery_charge'] = deliveryCharge;
    data['map'] = map;
    data['firebase'] = firebase;
    data['referral_amount'] = referralAmount;
    data['timezone'] = timezone;
    data['lat'] = lat;
    data['lang'] = lang;
    data['image'] = image;
    data['logo'] = logo;
    data['footer_logo'] = footerLogo;
    data['favicon'] = favicon;
    data['og_image'] = ogImage;
    data['verification'] = verification;
    data['current_version'] = currentVersion;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['app_bottom_image_url'] = appBottomImageUrl;
    data['is_app_bottom_image'] = isAppBottomImage;
    return data;
  }
}
