import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/order_section/model/sales_record_model.dart';
import 'package:flutter/cupertino.dart';

class SalesRecordProvider extends ChangeNotifier {

  static bool isSearchTypeChange = false;

  List<SalesRecordModel> getSalesRecordlist = [];
  getSalesRecord(
      BuildContext context,
      String? customerId,
      String? dateFrom,
      String? dateTo,
      String? userFullName,
      ) async {
    getSalesRecordlist = await ApiService.fetchSalesRecord(context,customerId,dateFrom,dateTo,userFullName);
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