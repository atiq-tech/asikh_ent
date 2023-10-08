import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/customer_section/model/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier{

  List<EmployeeModel> allEmployeeList = [];
  getEmployee(
      // BuildContext context,
      // {String? dateFrom,
      //   String? dateTo,
      //   String? customerId,
      //   String? employeeId,
      //   productId,
      //   String? userFullName
      //}
      ) async {
    allEmployeeList =
    await ApiService.fetchAllEmployee(
        //dateFrom, dateTo, customerId, employeeId, productId, userFullName
    );
    // return By_all_employee_ModelClass_List;
    notifyListeners();
  }

}