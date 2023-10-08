import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/order_section/model/sale_details_model.dart';
import 'package:flutter/material.dart';

class SaleDetailsProvider extends ChangeNotifier {

  static bool isSearchTypeChange = false;

  List<SaleDetailsModel> getSaleDetailsList = [];
  getSaleDetails(
      BuildContext context,
      String? categoryId,
      String? dateFrom,
      String? dateTo,
      String? productId,
      ) async {
    getSaleDetailsList = await ApiService.fetchSaleDetails(context,categoryId,dateFrom,dateTo,productId);
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