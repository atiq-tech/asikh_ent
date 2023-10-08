import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/customer_section/model/area_model.dart';
import 'package:flutter/material.dart';

class AreaProvider extends ChangeNotifier{

  List<AreaModel> allAreaList = [];
  static bool isCustomerTypeChange = false;
  getArea() async {
    allAreaList =
    await ApiService.fetchAllArea();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(Duration(seconds: 1),() {
      print('offff');
      isCustomerTypeChange = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isCustomerTypeChange = true;
    notifyListeners();
  }
}