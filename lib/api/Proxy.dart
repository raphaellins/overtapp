import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:overtapp/models/GameDetail.dart';

class Proxy {
  var bearer =
      "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjU1NGE3NTQ3Nzg1ODdjOTRjMTY3M2U4ZWEyNDQ2MTZjMGMwNDNjYmMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb3ZlcnRsaXRlIiwiYXVkIjoib3ZlcnRsaXRlIiwiYXV0aF90aW1lIjoxNTk2NDExMzU2LCJ1c2VyX2lkIjoibFZ2OW0yZFBlZFFDOHFkeWE5S0xJY1dPUnJLMiIsInN1YiI6ImxWdjltMmRQZWRRQzhxZHlhOUtMSWNXT1JySzIiLCJpYXQiOjE1OTY0MTEzNTYsImV4cCI6MTU5NjQxNDk1NiwiZW1haWwiOiJyYXBoYWxpbm5zQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJyYXBoYWxpbm5zQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.XBoEUo-It2jeYn26c05YbAZW7KjEmLkOf_SQm8zBBBIeLkqhttVxGVVBvonrfrWYWQcSIkM7hiEhHm6KmTppYbL91h3vQevuc47YAoH_vOdZC2PwaYMBxhl23_dCJhy3R7GopPrEH-xQdi1N5E8TVSzG6lk8d4o2RuTPug5Gp8UPq_6qpnPQZUGHazUP44BPd_DjBxjMC6-Rxr9tTsIGfoYH6rF-bVDkb9XJv1BzqnyxSi1tVsnQcV09TT862q4fYnzNXSmYTlYbpiO2zc9BNokIVXOpW9wI8HMQREhBrRnyReU7WPXdqGUs-_aoHUTNeCn7v-iDcLnU3Ln5OVY6ag";
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
