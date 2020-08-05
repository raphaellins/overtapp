import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:json_string/json_string.dart';
import 'package:overtapp/models/GameDetail.dart';
import 'package:overtapp/models/NewGame.dart';

class Proxy {
  var bearer =
      "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImFmMDg2ZmE4Y2Q5NDFlMDY3ZTc3NzNkYmIwNDcxMjAxMTBlMDA1NGEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb3ZlcnRsaXRlIiwiYXVkIjoib3ZlcnRsaXRlIiwiYXV0aF90aW1lIjoxNTk2NTkwMTQzLCJ1c2VyX2lkIjoibFZ2OW0yZFBlZFFDOHFkeWE5S0xJY1dPUnJLMiIsInN1YiI6ImxWdjltMmRQZWRRQzhxZHlhOUtMSWNXT1JySzIiLCJpYXQiOjE1OTY1OTAxNDMsImV4cCI6MTU5NjU5Mzc0MywiZW1haWwiOiJyYXBoYWxpbm5zQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJyYXBoYWxpbm5zQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.Iv1Pd7P9SPP0Jw_Wf7KNKizpmfdtA6YUFwtuTeYJ5VY4IpL69GkFrauKZv3MVfY86e1LqOqPIL1BBEx0H7ubhA54yQX5UEcFeu6fKDlRe4JysRr-fCPlPwaMsSSpo7flQYaEPW_gGRSzpQWMGXL7RHw-LeRo_VFsHgJo0NYPiy1Ouz36O1gVJHAdi-6r2PkzFgRBc6K4PqVGEKMY83ZibiFHpltjJO-1RtN1X-u_xOR9XyL-vI6dN23RAN2_XoMAD5sf4Psuur5jNCaD3DP9virLU6QSM8SWH2NCD3px73JRNI-4BMmqg3PJ4vKN-G3S-31SfdcgC4vS7XEI6U-f1A";
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
