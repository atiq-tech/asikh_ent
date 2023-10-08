import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/customer_section/model/customer_list_model.dart';
import 'package:flutter/material.dart';

class CustomerListProvider extends ChangeNotifier {
  List<CustomerListModel> customerList = [];
  static bool isCustomerTypeChange = false;

  getCustomerList(BuildContext context,
      {String? customerType}) async {
    customerList = await ApiService.fetchCustomerList(context, customerType);
    customerList.insert(0, CustomerListModel(displayName: "General Customer"));
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