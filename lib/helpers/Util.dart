

import 'package:shared_preferences/shared_preferences.dart';

class Common{
  static final String isLogin = "no";
  static final String name = "name";

  static getIsLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool login = _prefs.getBool(Common.isLogin) ?? false ;

    return login;
  }
  static getName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userName = _prefs.getString(Common.name) ?? '';

    return userName;
  }
}