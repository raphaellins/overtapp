import 'package:flutter/material.dart';

import 'api/Proxy.dart';
import 'models/GameDetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Overt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Overt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: FutureBuilder(
          future: Proxy().getGames(),
          builder: (context, snapshot) => ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: Colors.white,
                  ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                GameDetail gameDetail = snapshot.data[index];
                return gameDetailItem(gameDetail);
              }),
        ),
      ),
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
          color: Colors.black87,
        ),
        playedBalls(gameDetail.numbersPlayed),
        SizedBox(
          height: 5,
        ),
        sortedBalls(gameDetail.numbersDrawn)
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

Widget sortedBalls(List<String> ballsSorted) {
  List<Widget> balls = new List<Widget>();
  for (var i = 0; i < ballsSorted.length; i++) {
    balls.add(ball(ballsSorted[i]));
  }

  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, children: balls);
}

Widget ball(String ballNumber) {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      border: Border.all(),
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(9.9)),
    ),
    child: new Text(
      "$ballNumber",
    ),
  );
}
