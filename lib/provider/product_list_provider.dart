import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/customer_section/model/employee_model.dart';
import 'package:ashik_enterprise/order_section/model/product_list_model.dart';
import 'package:flutter/material.dart';

class ProductListProvider extends ChangeNotifier{

  List<ProductListModel> allProductList = [];
  Future<List<ProductListModel>>getProduct(
      String? catId, String? isService,
      ) async {
    return allProductList =
    await ApiService.fetchAllProduct(
        catId,isService
    );
    // notifyListeners();
  }

}