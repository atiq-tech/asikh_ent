import 'package:flutter/material.dart';

String baseUrl = "http://ashik.expressretailbd.com/";

List customerNameItems = [
  {"name": "A P DIGITAL COSMATIC\n(CHOCK BAZAR)", "image": "images/ord4.jpg"},
  {"name": "ABDUL ROB STOR\n(KHALER GUT)", "image": "images/ord7.png"},
  {"name": "ABDUL HOSAIN STOR\n(CHOCK BAZAR)", "image": "images/ord6.png"},
  {"name": "ABDUL HOSAIN STOR\n(MOULOBI BAZAR)", "image": "images/ord7.png"},
  {"name": "AKASH STOR\n(NOYA KHANDI BAZAR)", "image": "images/ord8.png"},
  {"name": "ALOM STOR\n(MOULOBI BAZAR)", "image": "images/ord9.webp"},
  {"name": "ALOM STOR\n(NOULA SCHOOL MOOR)", "image": "images/ord10.png"},
  {"name": "BAI BAI STOR\n(MOULOBI BAZAR)", "image": "images/ord7.png"},
  {"name": "RHIZ STOR\n(HIGH SCHOOL MOOR)", "image": "images/ord5.png"},
];

List screenItems = [
  {"name": "Order Entry", "image": "images/oentry.png"},
  {"name": "Order Record", "image": "images/orecord.png"},
  {"name": "Customer Entry", "image": "images/centry.png"},
  {"name": "Customer List", "image": "images/clist.png"},
  {"name": "Category Entry", "image": "images/centry.png"},
  {"name": "Route List", "image": "images/rlist.png"},
  {"name": "Log Out", "image": "images/logot.png"},
];

class AddToOrderModel {
  String? productId;
  String? productName;
  String? productImage;
  String? salesRate;
  String? boxQuantity;
  String? quantity;
  String? total;

  AddToOrderModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.salesRate,
    required this.boxQuantity,
    required this.quantity,
    required this.total,
  });
}