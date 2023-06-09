// ignore_for_file: camel_case_types, prefer_collection_literals

class forgot_passModel {
  int? status;
  String? message;

  forgot_passModel({this.status, this.message});

  forgot_passModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
