import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/order_section/model/get_sales_model.dart';
import 'package:flutter/material.dart';

class GetSalesProvider extends ChangeNotifier {

  static bool isSearchTypeChange = false;

  List<GetSalesModel> getSaleslist = [];
  getGatSales(
      BuildContext context,
      String? customerId,
      String? dateFrom,
      String? dateTo,
      String? userFullName,
      ) async {
    getSaleslist = await ApiService.fetchGetSales(context,customerId,dateFrom,dateTo,userFullName);
    off();
    notifyListeners();
  }


  off(){
    Future.delayed(Duration(seconds: 1),() {
      print('offff');
      isSearchTypeChange = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isSearchTypeChange = true;
    notifyListeners();
  }
}