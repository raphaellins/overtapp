import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:overtapp/models/GameDetail.dart';

class Proxy {
  var bearer =
      "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjU1NGE3NTQ3Nzg1ODdjOTRjMTY3M2U4ZWEyNDQ2MTZjMGMwNDNjYmMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb3ZlcnRsaXRlIiwiYXVkIjoib3ZlcnRsaXRlIiwiYXV0aF90aW1lIjoxNTk2MzMwOTUzLCJ1c2VyX2lkIjoibFZ2OW0yZFBlZFFDOHFkeWE5S0xJY1dPUnJLMiIsInN1YiI6ImxWdjltMmRQZWRRQzhxZHlhOUtMSWNXT1JySzIiLCJpYXQiOjE1OTYzMzA5NTMsImV4cCI6MTU5NjMzNDU1MywiZW1haWwiOiJyYXBoYWxpbm5zQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJyYXBoYWxpbm5zQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.EDPEyV4x4yXM2faKkdtCvyAU4BldxoRpWtcGpkZwp9k47Z9abopepMBNhXH6TU5wFYLY7KJnAn6oE1CFomusfT26qCU9ZE07dyoOWCQfvTaOttFYwUy-guoNDvcsaWjjwENeDITQe3M8GEKVxxO8EW7ZtLHuIhUmSlLlJA1DHm3ciMPbdcSDKAM9kTZAtxQFmi-tw3MYsFSyYKVXQHAzb0JMBmQ4lAsuEeiffK0F4B0Act-9zQl4dSAWJQAuy0x64BleRtb5PC56nsDQRL2h5yRrUa0CEIcHIBacfjXQpNuFNi3F9oPMtdiMEkR5eKnInktlditde5p5greFnJXilA";
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
