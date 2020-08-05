import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:json_string/json_string.dart';
import 'package:overtapp/models/GameDetail.dart';
import 'package:overtapp/models/NewGame.dart';

class Proxy {
  var bearer =
      "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImFmMDg2ZmE4Y2Q5NDFlMDY3ZTc3NzNkYmIwNDcxMjAxMTBlMDA1NGEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb3ZlcnRsaXRlIiwiYXVkIjoib3ZlcnRsaXRlIiwiYXV0aF90aW1lIjoxNTk2NjY0ODgxLCJ1c2VyX2lkIjoibFZ2OW0yZFBlZFFDOHFkeWE5S0xJY1dPUnJLMiIsInN1YiI6ImxWdjltMmRQZWRRQzhxZHlhOUtMSWNXT1JySzIiLCJpYXQiOjE1OTY2NjQ4ODEsImV4cCI6MTU5NjY2ODQ4MSwiZW1haWwiOiJyYXBoYWxpbm5zQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJyYXBoYWxpbm5zQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.HHHxdUpiaec1OSeypUS2FsBk-WHReKRbsMWNrg_F4l6dFYQX-mYKq3gDWKrfIt9eTwhy08ttQWcGSIy5V8nVhGMqjAiBe8lchneQoMQfNLh_EbinP0tcw2Nmlxt0-u4D0FFc9r7RfqKp9mzI-IrzGK4e7nqgSq1RtX4AL7Hhd3spxZwTjTCegBjK6A_Z6CbjoaSSucnTaCB65134rMdvMlKGFna62oySVwnGgaBPZVmcJF7zA_npvOG2kzwWOTHjowzi04J00xKVccQfglUSyoEi1V-wHfulnZmtncmAlfh_3RQPpANSFg0PDZuZ4AUg-XNRCKsokbFw7ozAoJpPDA";
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

  saveNewGame(NewGame newGame) async {
    var finalUrl = url + "new-game";
    var requestData = json.encode(newGame);

    await http.post(finalUrl, body: requestData, headers: {
      HttpHeaders.authorizationHeader: bearer,
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
    });
  }

  saveNewDraw(NewGame newGame) async {
    var finalUrl = url + "new-game";

    JsonString requestData = JsonString.encodeObject(newGame);

    print(requestData.toString());

    await http.post(finalUrl, body: requestData, headers: {
      HttpHeaders.authorizationHeader: bearer,
      HttpHeaders.contentTypeHeader: "application/json"
    });
  }
}
