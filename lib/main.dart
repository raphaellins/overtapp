import 'package:flutter/material.dart';
import 'package:overtapp/utils/NumberUtils.dart';

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
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
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
                    children: <Widget>[Text("20/10/2020"), Text("13")],
                  ),
                  Divider(
                    color: Colors.black87,
                  ),
                  playedBalls(),
                  SizedBox(
                    height: 5,
                  ),
                  sortedBalls()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget playedBalls() {
  List<Widget> balls = new List<Widget>();
  for (var i = 0; i < 15; i++) {
    String ballNumber = NumberUtils().formatBallNumber(i);
    balls.add(ball(ballNumber));
  }

  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, children: balls);
}

Widget sortedBalls() {
  List<Widget> balls = new List<Widget>();
  for (var i = 0; i < 15; i++) {
    String ballNumber = NumberUtils().formatBallNumber(i);
    balls.add(ball(ballNumber));
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
