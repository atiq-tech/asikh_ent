import 'package:ashik_enterprise/api_services/api_service.dart';
import 'package:ashik_enterprise/sreens/model/user_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider extends ChangeNotifier {

  UserDataModel? userDataModellist;
  SharedPreferences? sharedPreferences;

  Future<UserDataModel?>getUserData(context) async {
    userDataModellist = await ApiService.fetchGetUserData(context);
    // notifyListeners();
    return userDataModellist;
  }
}