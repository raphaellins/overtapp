import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:json_string/json_string.dart';
import 'package:overtapp/models/GameDetail.dart';
import 'package:overtapp/models/NewGame.dart';

class Proxy {
  var bearer =
      "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImFmMDg2ZmE4Y2Q5NDFlMDY3ZTc3NzNkYmIwNDcxMjAxMTBlMDA1NGEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb3ZlcnRsaXRlIiwiYXVkIjoib3ZlcnRsaXRlIiwiYXV0aF90aW1lIjoxNTk2NzUwNjU4LCJ1c2VyX2lkIjoibFZ2OW0yZFBlZFFDOHFkeWE5S0xJY1dPUnJLMiIsInN1YiI6ImxWdjltMmRQZWRRQzhxZHlhOUtMSWNXT1JySzIiLCJpYXQiOjE1OTY3NTA2NTgsImV4cCI6MTU5Njc1NDI1OCwiZW1haWwiOiJyYXBoYWxpbm5zQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJyYXBoYWxpbm5zQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.VeaYOhQWy2Pb5-cc1hCxTvNGSn7cWyQ1LvDqhbfa39zoDfbCBBKdKzbGMSfPUTp2vGOlhMZE2WqBUS65djHKKeYQanOMuUNW2q374PBcS_msZoHJRLheKr0l_W9339ZCcK0WfKdu1oNJ4YKTCX_MP5A9iKfjDLQaku5DiomVrF35IGIEFjYSQUIVY3Xs213a5VZEcM4aEghpIsUjd5TGvOfBjSPaSdITJ-pyV9AIpJp38sv1dhN3_1SFvd82Pbnsh_TbO_G734Nm3u3et3dMlml6Tsln4eKsYEQ17ja1YqpFNBnxZ_BO9NmQIzlG5elqD2F-W0Uxrc0sVLTQSzmqjA";
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

  saveNewDraw(NewGame newGame, Function onFinish) {
    var finalUrl = url + "new-game";

    JsonString requestData = JsonString.encodeObject(newGame);

    print(requestData.toString());

    http.post(finalUrl, body: requestData, headers: {
      HttpHeaders.authorizationHeader: bearer,
      HttpHeaders.contentTypeHeader: "application/json"
    }).then((value) {
      onFinish(value.statusCode == 200);
    });
  }
}
