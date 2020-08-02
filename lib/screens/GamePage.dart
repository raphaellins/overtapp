import 'package:flutter/material.dart';
import 'package:overtapp/elements/Ball.dart';
import 'package:overtapp/utils/NumberUtils.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> numbersSelected = new List<String>();

  _onNumberTap(String ballNumber, bool selected) {
    print("$ballNumber  $selected");

    if (selected) {
      numbersSelected.add(ballNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        padding: EdgeInsets.only(right: 30, left: 30),
        margin: EdgeInsets.only(right: 30, left: 30, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "Initial Game Number"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Final Game Number"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "Game Description"),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  createCard(1, 5, _onNumberTap),
                  SizedBox(
                    height: 5,
                  ),
                  createCard(6, 10, _onNumberTap),
                  SizedBox(
                    height: 5,
                  ),
                  createCard(11, 15, _onNumberTap),
                  SizedBox(
                    height: 5,
                  ),
                  createCard(16, 20, _onNumberTap),
                  SizedBox(
                    height: 5,
                  ),
                  createCard(21, 25, _onNumberTap),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget createCard(int initialNumber, int endNumber, Function onNumberTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: ballRow(initialNumber, endNumber, onNumberTap),
  );
}

List<Widget> ballRow(int initialNumber, int endNumber, Function onNumberTap) {
  List<Widget> balls = new List<Widget>();
  for (int i = initialNumber; i <= endNumber; i++) {
    String ballNumber = NumberUtils().formatBallNumber(i);

    balls.add(Ball(ballNumber, onNumberTap));
  }
  return balls;
}
