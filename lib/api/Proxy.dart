import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:overtapp/models/GameDetail.dart';

class Proxy {
  var bearer =
      "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjU1NGE3NTQ3Nzg1ODdjOTRjMTY3M2U4ZWEyNDQ2MTZjMGMwNDNjYmMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb3ZlcnRsaXRlIiwiYXVkIjoib3ZlcnRsaXRlIiwiYXV0aF90aW1lIjoxNTk2MzczMTk3LCJ1c2VyX2lkIjoibFZ2OW0yZFBlZFFDOHFkeWE5S0xJY1dPUnJLMiIsInN1YiI6ImxWdjltMmRQZWRRQzhxZHlhOUtMSWNXT1JySzIiLCJpYXQiOjE1OTYzNzMxOTcsImV4cCI6MTU5NjM3Njc5NywiZW1haWwiOiJyYXBoYWxpbm5zQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJyYXBoYWxpbm5zQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.p1cmr3qlUFvEkqWRKw5ZYVEWVxpVmlKg9LmeeF3yqj_RHXmOaNixGqKX9OS4Tjiw9QI7IWqs4dg2sgdaHt5yQsGcrSluFerGyiU2LfErS3Mwded1luQcJms321re-Gli8PoOWwl-k33LCTcKs7APtnYCnAh8iY2bl19bVTzyIJ7Gc_loWbIQf1pBuZ3sTeRAnyuwB59bsfkR4dB2Z_g6hUlu96x5kof1-9ZYF9GWyg3B6FckYsEQfh-fRkVknGNAUZp4KwhcC2JdhLcpY2BwJ4KvrRWyasmud1p3Cu-ZCHxjV_fohXKSWPsElVT9L45VlyoiyGHlEhICxYO_rLjShg";
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
