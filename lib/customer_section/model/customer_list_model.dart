import 'package:meta/meta.dart';
import 'dart:convert';

class CustomerListModel {
  final String? customerSlNo;
  final String? customerCode;
  final String? customerName;
  final String? customerType;
  final String? customerPhone;
  final String? customerMobile;
  final String? customerEmail;
  final String? customerOfficePhone;
  final String? customerAddress;
  final String? ownerName;
  final String? employeeId;
  final String? countrySlNo;
  final String? areaId;
  final String? customerWeb;
  final String? customerCreditLimit;
  final String? previousDue;
  final dynamic imageName;
  final String? status;
  final String? addBy;
  final String? addTime;
  final String? updateBy;
  final String? updateTime;
  final String? customerBrunchid;
  final String? districtName;
  final String? displayName;

  CustomerListModel({
     this.customerSlNo,
     this.customerCode,
     this.customerName,
     this.customerType,
     this.customerPhone,
     this.customerMobile,
     this.customerEmail,
     this.customerOfficePhone,
     this.customerAddress,
     this.ownerName,
     this.employeeId,
     this.countrySlNo,
     this.areaId,
     this.customerWeb,
     this.customerCreditLimit,
     this.previousDue,
     this.imageName,
     this.status,
     this.addBy,
     this.addTime,
     this.updateBy,
     this.updateTime,
     this.customerBrunchid,
     this.districtName,
     this.displayName,
  });

  factory CustomerListModel.fromJson(String str) => CustomerListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerListModel.fromMap(Map<String, dynamic> json) => CustomerListModel(
    customerSlNo: json["Customer_SlNo"]??"",
    customerCode: json["Customer_Code"]??"",
    customerName: json["Customer_Name"]??"",
    customerType: json["Customer_Type"]??"",
    customerPhone: json["Customer_Phone"]??"",
    customerMobile: json["Customer_Mobile"]??"",
    customerEmail: json["Customer_Email"]??"",
    customerOfficePhone: json["Customer_OfficePhone"]??"",
    customerAddress: json["Customer_Address"]??"",
    ownerName: json["owner_name"]??"",
    employeeId: json["Employee_Id"]??"",
    countrySlNo: json["Country_SlNo"]??"",
    areaId: json["area_ID"]??"",
    customerWeb: json["Customer_Web"]??"",
    customerCreditLimit: json["Customer_Credit_Limit"]??"",
    previousDue: json["previous_due"]??"",
    imageName: json["image_name"],
    status: json["status"]??"",
    addBy: json["AddBy"]??"",
    addTime: json["AddTime"]??"",
    updateBy: json["UpdateBy"]??"",
    updateTime: json["UpdateTime"]??"",
    customerBrunchid: json["Customer_brunchid"]??"",
    districtName: json["District_Name"]??"",
    displayName: json["display_name"]??"",
  );

  Map<String, dynamic> toMap() => {
    "Customer_SlNo": customerSlNo,
    "Customer_Code": customerCode,
    "Customer_Name": customerName,
    "Customer_Type": customerType,
    "Customer_Phone": customerPhone,
    "Customer_Mobile": customerMobile,
    "Customer_Email": customerEmail,
    "Customer_OfficePhone": customerOfficePhone,
    "Customer_Address": customerAddress,
    "owner_name": ownerName,
    "Employee_Id": employeeId,
    "Country_SlNo": countrySlNo,
    "area_ID": areaId,
    "Customer_Web": customerWeb,
    "Customer_Credit_Limit": customerCreditLimit,
    "previous_due": previousDue,
    "image_name": imageName,
    "status": status,
    "AddBy": addBy,
    "AddTime": addTime,
    "UpdateBy": updateBy,
    "UpdateTime": updateTime,
    "Customer_brunchid": customerBrunchid,
    "District_Name": districtName,
    "display_name": displayName,
  };
}
