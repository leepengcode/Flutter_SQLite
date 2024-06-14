import 'package:auth_app/screen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isChecked = false;
  bool get isChecked => _isChecked;
  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  late SharedPreferences storage;

  toggleCheck() {
    _isChecked = !isChecked;
    notifyListeners();
  }

  setRememberMe() {
    _rememberMe = true;
    storage.setBool("rememberMe", _rememberMe);
    notifyListeners();
  }

  logout(BuildContext context) {
    _rememberMe = false;
    storage.setBool("rememberMe", _rememberMe);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
    notifyListeners();
  }

  //Init Secure Storage

  initStorage() async {
    storage = await SharedPreferences.getInstance();
    _rememberMe = storage.getBool("rememberMe") ?? false;
    notifyListeners();
  }
}
