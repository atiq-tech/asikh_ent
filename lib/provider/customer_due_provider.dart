import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/order_section/model/customer_due_model.dart';
import 'package:flutter/material.dart';

class CustomerDueProvider extends ChangeNotifier{

  List<CustomerDueModel> customerDueList = [];
  getCustomerDue(
      String? customerId
      ) async {
    customerDueList =
    await ApiService.fetchCustomerDue(customerId);
    notifyListeners();
  }

}