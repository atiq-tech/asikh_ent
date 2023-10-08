import 'package:meta/meta.dart';
import 'dart:convert';

class AllUserModel {
  final String userSlNo;
  final String userId;
  final String employeeId;
  final String fullName;
  final String userName;
  final String userEmail;
  final String userBrunchId;
  final String userPassword;
  final String userType;
  final String status;
  final String verifycode;
  final dynamic imageName;
  final dynamic addBy;
  final String addTime;
  final dynamic updateBy;
  final dynamic updateTime;
  final String brunchId;

  AllUserModel({
    required this.userSlNo,
    required this.userId,
    required this.employeeId,
    required this.fullName,
    required this.userName,
    required this.userEmail,
    required this.userBrunchId,
    required this.userPassword,
    required this.userType,
    required this.status,
    required this.verifycode,
    required this.imageName,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
    required this.brunchId,
  });

  factory AllUserModel.fromJson(String str) => AllUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllUserModel.fromMap(Map<String, dynamic> json) => AllUserModel(
    userSlNo: json["User_SlNo"]??"",
    userId: json["User_ID"]??"",
    employeeId: json["employee_id"]??"",
    fullName: json["FullName"]??"",
    userName: json["User_Name"]??"",
    userEmail: json["UserEmail"]??"",
    userBrunchId: json["userBrunch_id"]??"",
    userPassword: json["User_Password"]??"",
    userType: json["UserType"]??"",
    status: json["status"]??"",
    verifycode: json["verifycode"]??"",
    imageName: json["image_name"],
    addBy: json["AddBy"],
    addTime: json["AddTime"]??"",
    updateBy: json["UpdateBy"],
    updateTime: json["UpdateTime"],
    brunchId: json["Brunch_ID"]??"",
  );

  Map<String, dynamic> toMap() => {
    "User_SlNo": userSlNo,
    "User_ID": userId,
    "employee_id": employeeId,
    "FullName": fullName,
    "User_Name": userName,
    "UserEmail": userEmail,
    "userBrunch_id": userBrunchId,
    "User_Password": userPassword,
    "UserType": userType,
    "status": status,
    "verifycode": verifycode,
    "image_name": imageName,
    "AddBy": addBy,
    "AddTime": addTime,
    "UpdateBy": updateBy,
    "UpdateTime": updateTime,
    "Brunch_ID": brunchId,
  };
}
