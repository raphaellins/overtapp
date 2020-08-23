import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:overtapp/api/Proxy.dart';
import 'package:overtapp/models/User.dart';

enum UserStateEnum { LOGGED, PROCESSING, EMPTY }

class UserState {
  User user;
  UserStateEnum userState = UserStateEnum.EMPTY;
}

class AuthService with ChangeNotifier {
  UserState _currentUser = new UserState();

  Future<UserState> getUser() {
    return Future.value(_currentUser);
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("overtapptoken", "");
    _currentUser.userState = UserStateEnum.EMPTY;
    notifyListeners();
  }

  Future<UserState> loginUser({String email, String password}) async {
    try {
      _currentUser.userState = UserStateEnum.PROCESSING;
      notifyListeners();

      User user = await new Proxy().login(new User(email, password));

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("overtapptoken", user.getToken());
      preferences.setString("overtappuser", user.email);
      preferences.setString("overtapppassword", user.password);

      this._currentUser.user = user;
      _currentUser.userState = UserStateEnum.LOGGED;
      notifyListeners();

      return Future.value(this._currentUser);
    } catch (e) {
      print("Error in login $e");
      return null;
    }
  }
}
