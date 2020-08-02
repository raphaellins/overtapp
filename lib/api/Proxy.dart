import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:overtapp/models/GameDetail.dart';

class Proxy {
  var bearer =
      "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjU1NGE3NTQ3Nzg1ODdjOTRjMTY3M2U4ZWEyNDQ2MTZjMGMwNDNjYmMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb3ZlcnRsaXRlIiwiYXVkIjoib3ZlcnRsaXRlIiwiYXV0aF90aW1lIjoxNTk2Mzc2ODI3LCJ1c2VyX2lkIjoibFZ2OW0yZFBlZFFDOHFkeWE5S0xJY1dPUnJLMiIsInN1YiI6ImxWdjltMmRQZWRRQzhxZHlhOUtMSWNXT1JySzIiLCJpYXQiOjE1OTYzNzY4MjcsImV4cCI6MTU5NjM4MDQyNywiZW1haWwiOiJyYXBoYWxpbm5zQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJyYXBoYWxpbm5zQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.MbPaMqlK5cPGO0vFRhko2_j51xT8phe7kl0yGQ17t9MMTEasXaftXaiWQmZLWWhBvlkhqZMEXQTxu6mNG4DZ_jj83xqh1VZ_vl6r6FxjC9vi-S9Lesdio8zqt-RTHCCUvpUACHqyOXVfWwbPCccM-5d1iIk3dujPdlD9HPIDkrxxc0hj176mmffNVglAIeeQevoVOBewKx_lgPGj1OlmHSOhYY2CM6TqBTZ8At38gTjInx17u7i-Z12_3UMMeX-H-ZzeTNLW5P69Gm2eLtYh49wcLyaR850q-avFWgOs-Ic4zrtXA0tKBUO_JTAppWl5dLHW_Dxbn5GKrPI3gfo-Bg";
  var url = 'https://us-central1-overtlite.cloudfunctions.net/api/';

  Future<List<GameDetail>> getGames() async {
    var finalUrl = url + "games";

    var response = await http
        .get(finalUrl, headers: {HttpHeaders.authorizationHeader: bearer});

    print(response.statusCode);

    final responseJson = json.decode(response.body);

    List<GameDetail> gamesDetail = new List<GameDetail>();

    for (Map<String, dynamic> gameDetail in responseJson) {
      gamesDetail.add(GameDetail.fromJson(gameDetail));
    }

    return gamesDetail;
  }
}
