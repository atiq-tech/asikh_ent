import 'dart:convert';
import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/sreens/model/all_user_model.dart';
import 'package:ashik_enterprise/sreens/model/current_stock_model.dart';
import 'package:flutter/material.dart';

class AllUserProvider extends ChangeNotifier{

  static bool isLoading = false;
  List<AllUserModel> allUserlist = [];
  getUser(BuildContext context,
      // String stockType
      ) async {
    allUserlist = await ApiService.fetchAllUser(context,
      // stockType
    );
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(Duration(seconds: 1),() {
      print('offff');
      isLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isLoading = true;
    notifyListeners();
  }
}