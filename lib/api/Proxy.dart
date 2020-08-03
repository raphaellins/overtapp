import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:overtapp/models/GameDetail.dart';
import 'package:overtapp/models/NewGame.dart';

class Proxy {
  var bearer =
      "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjU1NGE3NTQ3Nzg1ODdjOTRjMTY3M2U4ZWEyNDQ2MTZjMGMwNDNjYmMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb3ZlcnRsaXRlIiwiYXVkIjoib3ZlcnRsaXRlIiwiYXV0aF90aW1lIjoxNTk2NDkxNTkzLCJ1c2VyX2lkIjoibFZ2OW0yZFBlZFFDOHFkeWE5S0xJY1dPUnJLMiIsInN1YiI6ImxWdjltMmRQZWRRQzhxZHlhOUtMSWNXT1JySzIiLCJpYXQiOjE1OTY0OTE1OTMsImV4cCI6MTU5NjQ5NTE5MywiZW1haWwiOiJyYXBoYWxpbm5zQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJyYXBoYWxpbm5zQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.BYco4P8UjbO4OVPhqQh1i5Oxn3zjBMJQq2NeorNmGfk_rPqnPgknmGezIVc_3n6W_O-9cUyPhp1e20GtmJjvMBmlmotKkjBaVKWyEd1Qf46zjh4DxoCDM3taFxqQYllOsZTjkbt0uWRogmy-WZ7tV1ssOq27JQn3yemiOHY1O7tHvYIzwV6mwEzGel5eKstYSSxzNrwzeNA7122T_b-6x4_bwgx7UUeTS-46XHQj0CFiw81b52OxIvVIkM4q0HcRCH-RztJBF58jkooX8nND2OhSEcv0RdW34AgGRu7vTy50xTSWCfn7kURp6_YQI2CEbW-TNVF9oJaoz8B-jWCy0A";
  var url = 'https://us-central1-overtlite.cloudfunctions.net/api/';

  Future<List<GameDetail>> getGames() async {
    var finalUrl = url + "new-game";

    var response = await http
        .get(finalUrl, headers: {HttpHeaders.authorizationHeader: bearer});

    final responseJson = json.decode(response.body);

    List<GameDetail> gamesDetail = new List<GameDetail>();

    for (Map<String, dynamic> gameDetail in responseJson) {
      gamesDetail.add(GameDetail.fromJson(gameDetail));
    }

    return gamesDetail;
  }

  saveNewGame(NewGame newGame) {
    var requestData = json.encode(newGame.toJson());

    print(requestData);
  }
}
