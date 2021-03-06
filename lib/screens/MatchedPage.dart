import 'package:flutter/material.dart';
import 'package:overtapp/api/Auth.dart';
import 'package:overtapp/api/Proxy.dart';
import 'package:overtapp/models/GameDetail.dart';
import 'package:provider/provider.dart';

class MatchedPage extends StatefulWidget {
  @override
  _MatchedPageState createState() => _MatchedPageState();
}

class _MatchedPageState extends State<MatchedPage> {
  List<GameDetail> _matchedGames;

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  Future<void> _retrieveData() async {
    try {
      List<GameDetail> responseGames = await new Proxy().getGames();

      List<GameDetail> copyData = responseGames;

      copyData.sort(
          (GameDetail a, GameDetail b) => b.gameNumber.compareTo(a.gameNumber));

      setState(() {
        _matchedGames = copyData
            .where(
                (GameDetail gameDetail) => gameDetail.numbersDrawn.length > 0)
            .toList();
      });
    } catch (err) {
      Provider.of<AuthService>(context).logout();
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      child: RefreshIndicator(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.transparent,
              height: 5,
            ),
            itemCount: _matchedGames == null ? 0 : _matchedGames.length,
            itemBuilder: (context, index) {
              GameDetail gameDetail = _matchedGames[index];
              return gameDetailItem(context, gameDetail);
            },
          ),
          onRefresh: _retrieveData),
    );
  }
}

Widget gameInfo(String value) {
  return Text(value, style: TextStyle(color: Colors.black87));
}

Widget gameDetailItem(BuildContext context, GameDetail gameDetail) {
  String gameNumber = gameDetail.gameNumber;
  String gameDescription = gameDetail.gameDescription;
  String countMatched = gameDetail.countMatched.toString();

  return Container(
    padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    height: 96,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            gameInfo(gameNumber),
            gameInfo(gameDescription),
            gameInfo(countMatched),
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
    width: 24,
    height: 24,
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      border: Border.all(),
      color: matched ? Colors.green : Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    child: Center(
        child: Text(
      "$ballNumber",
      style: TextStyle(color: matched ? Colors.white : Colors.black),
    )),
  );
}
