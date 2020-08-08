import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:overtapp/models/GameDetail.dart';
import 'package:overtapp/models/NewDraw.dart';
import 'package:overtapp/models/NewGame.dart';
import 'package:overtapp/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Proxy {
  var bearer = "Bearer ";
  var url = 'https://us-central1-overtlite.cloudfunctions.net/api/';

  Future<List<GameDetail>> getGames() async {
    var finalUrl = url + "games";

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bearer += preferences.get("overtapptoken");

    var response = await http
        .get(finalUrl, headers: {HttpHeaders.authorizationHeader: bearer});

    final responseJson = json.decode(response.body);

    print("=========> STATUS CODE ${response.statusCode}");

    List<GameDetail> gamesDetail = new List<GameDetail>();

    for (Map<String, dynamic> gameDetail in responseJson) {
      gamesDetail.add(GameDetail.fromJson(gameDetail));
    }

    return gamesDetail;
  }

  Future<bool> saveNewGame(NewGame newGame) async {
    var finalUrl = url + "new-game";
    var requestData = json.encode(newGame);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bearer += preferences.get("overtapptoken");

    var response = await http.post(finalUrl, body: requestData, headers: {
      HttpHeaders.authorizationHeader: bearer,
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
    });

    return response.statusCode == 200;
  }

  Future<bool> saveNewDraw(NewDraw newDraw) async {
    var finalUrl = url + "new-draw";
    var requestData = json.encode(newDraw);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bearer += preferences.get("overtapptoken");

    var response = await http.post(finalUrl, body: requestData, headers: {
      HttpHeaders.authorizationHeader: bearer,
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
    });

    return response.statusCode == 200;
  }

  Future<User> login(User user) async {
    var finalUrl = url + "login";
    var requestData = json.encode(user);

    var response = await http.post(finalUrl, body: requestData, headers: {
      HttpHeaders.authorizationHeader: bearer,
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
    });

    dynamic content = jsonDecode(response.body);

    user.setToken(content["token"]);

    return user;
  }
}
