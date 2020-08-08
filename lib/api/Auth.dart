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

  Future logout() async {
    var result = Future.value();
    notifyListeners();
    return result;
  }

  Future<UserState> loginUser({String email, String password}) async {
    try {
      print("===> Login user");

      _currentUser.userState = UserStateEnum.PROCESSING;
      notifyListeners();

      User user = await new Proxy().login(new User(email, password));

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("overtapptoken", user.getToken());

      this._currentUser.user = user;
      _currentUser.userState = UserStateEnum.LOGGED;
      notifyListeners();

      return this._currentUser;
    } catch (e) {
      print("Error in login $e");
    }
  }
}
