import 'package:meta/meta.dart';
import 'dart:convert';

class UserDataModel {
  final int totalqty;
  final int todayOrder;
  final int todaysSale;
  final int monthlySale;
  final int totalCustomer;

  UserDataModel({
    required this.totalqty,
    required this.todayOrder,
    required this.todaysSale,
    required this.monthlySale,
    required this.totalCustomer,
  });

  factory UserDataModel.fromJson(String str) => UserDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromMap(Map<String, dynamic> json) => UserDataModel(
    totalqty: json["totalqty"]??0,
    todayOrder: json["today_order"]??0,
    todaysSale: json["todays_sale"]??0,
    monthlySale: json["monthly_sale"]??0,
    totalCustomer: json["total_customer"]??0,
  );

  Map<String, dynamic> toMap() => {
    "totalqty": totalqty,
    "today_order": todayOrder,
    "todays_sale": todaysSale,
    "monthly_sale": monthlySale,
    "total_customer": totalCustomer,
  };
}
