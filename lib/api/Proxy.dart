import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:json_string/json_string.dart';
import 'package:overtapp/models/GameDetail.dart';
import 'package:overtapp/models/NewDraw.dart';
import 'package:overtapp/models/NewGame.dart';

class Proxy {
  var bearer =
      "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImFmMDg2ZmE4Y2Q5NDFlMDY3ZTc3NzNkYmIwNDcxMjAxMTBlMDA1NGEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb3ZlcnRsaXRlIiwiYXVkIjoib3ZlcnRsaXRlIiwiYXV0aF90aW1lIjoxNTk2ODM2ODIxLCJ1c2VyX2lkIjoibFZ2OW0yZFBlZFFDOHFkeWE5S0xJY1dPUnJLMiIsInN1YiI6ImxWdjltMmRQZWRRQzhxZHlhOUtMSWNXT1JySzIiLCJpYXQiOjE1OTY4MzY4MjEsImV4cCI6MTU5Njg0MDQyMSwiZW1haWwiOiJyYXBoYWxpbm5zQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJyYXBoYWxpbm5zQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.R4wUtIPWbEf_D_a2b3nZhsO15e6nU4cqf2AZA5Hm7hSRHGJ1WYORLtVyPEi1G67twyJy5k54-0RxyDwuQRMnNKmmpGj2kHZOWu77kRnFjct9-tMMpEdJe-n_D4ygZpT0cbvfR3sznNwb-iG3rAQFqFPbFfUQYSFW8vdDtIelnNehz6-loApYUVqnO8HrUKFMv5jYzUyos5NmiNWmNsb77dXGPP1a0pItBuZSVWDlj-_VG9_6MTfulH9JpuiVgW5o0CF0JgZATt_CXBYzQ1JnDJKiCFhF6fpWgwUm9HdGAnNdP9dXHtWiExigY3vIzULOamKBWUzZzKYdF3ro31T4Hg";
  var url = 'https://us-central1-overtlite.cloudfunctions.net/api/';

  Future<List<GameDetail>> getGames() async {
    var finalUrl = url + "games";

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

    var response = await http.post(finalUrl, body: requestData, headers: {
      HttpHeaders.authorizationHeader: bearer,
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
    });

    return response.statusCode == 200;
  }

  Future<bool> saveNewDraw(NewDraw newDraw) async {
    var finalUrl = url + "new-draw";
    var requestData = json.encode(newDraw);

    var response = await http.post(finalUrl, body: requestData, headers: {
      HttpHeaders.authorizationHeader: bearer,
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
    });

    return response.statusCode == 200;
  }
}
