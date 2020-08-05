import 'package:flutter/material.dart';
import 'package:overtapp/api/Proxy.dart';
import 'package:overtapp/models/GameDetail.dart';

class MatchedPage extends StatefulWidget {
  @override
  _MatchedPageState createState() => _MatchedPageState();
}

class _MatchedPageState extends State<MatchedPage> {
  List<GameDetail> _games;

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  Future<void> _retrieveData() async {
    List<GameDetail> responseGames = await new Proxy().getGames();

    print("${responseGames.length} COUNT");
    setState(() {
      _games = responseGames;
    });

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      child: RefreshIndicator(
          child: ListView.builder(
            itemCount: _games == null ? 0 : _games.length,
            itemBuilder: (context, index) {
              GameDetail gameDetail = _games[index];
              return gameDetailItem(gameDetail);
            },
          ),
          onRefresh: _retrieveData),
    );
  }
}

Widget gameDetailItem(GameDetail gameDetail) {
  return Container(
    padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
    decoration: BoxDecoration(
      border: Border.all(),
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    height: 95,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(gameDetail.gameNumber),
            Text(gameDetail.gameDescription == null
                ? ""
                : gameDetail.gameDescription),
            Text(gameDetail.countMatched.toString())
          ],
        ),
        Divider(
          color: Colors.black,
        ),
        playedBalls(gameDetail.numbersPlayed),
        SizedBox(
          height: 5,
        ),
        sortedBalls(gameDetail)
      ],
    ),
  );
}

Widget playedBalls(List<String> ballsPlayed) {
  List<Widget> balls = new List<Widget>();
  for (var i = 0; i < ballsPlayed.length; i++) {
    balls.add(ball(ballsPlayed[i]));
  }

  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, children: balls);
}

Widget sortedBalls(GameDetail gameDetail) {
  List<Widget> balls = new List<Widget>();
  for (var i = 0; i < gameDetail.numbersDrawn.length; i++) {
    String ballDrawn = gameDetail.numbersDrawn[i];
    bool matched = gameDetail.numbersPlayed.contains(ballDrawn);

    balls.add(ball(ballDrawn, matched: matched));
  }

  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, children: balls);
}

Widget ball(String ballNumber, {matched = false}) {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      border: Border.all(),
      color: matched ? Colors.green : Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    child: new Text(
      "$ballNumber",
      style: TextStyle(color: matched ? Colors.white : Colors.black),
    ),
  );
}
