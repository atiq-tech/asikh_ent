import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/customer_section/model/area_model.dart';
import 'package:ashik_enterprise/sreens/model/category_model.dart';
import 'package:flutter/material.dart';

class AllCategoryProvider extends ChangeNotifier{
  List<CategoryModel> allCategoryList = [];
  getCategory() async {
    allCategoryList =
    await ApiService.fetchAllCategory();
    notifyListeners();
  }

}