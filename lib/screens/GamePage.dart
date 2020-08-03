import 'package:flutter/material.dart';
import 'package:overtapp/elements/Ball.dart';
import 'package:overtapp/utils/NumberUtils.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int numberSelectedCount = 0;
  String message = "";
  List<String> numbersSelected = new List<String>();

  _onNumberTap(String ballNumber, bool selected) {
    setState(() {
      if (selected) {
        numbersSelected.add(ballNumber);
      } else {
        numbersSelected.remove(ballNumber);
      }
      numberSelectedCount = numbersSelected.length;

      message = "$numberSelectedCount numbers selected";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: SingleChildScrollView(
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
                    createCard(1, 5, _onNumberTap, numberSelectedCount),
                    SizedBox(
                      height: 5,
                    ),
                    createCard(6, 10, _onNumberTap, numberSelectedCount),
                    SizedBox(
                      height: 5,
                    ),
                    createCard(11, 15, _onNumberTap, numberSelectedCount),
                    SizedBox(
                      height: 5,
                    ),
                    createCard(16, 20, _onNumberTap, numberSelectedCount),
                    SizedBox(
                      height: 5,
                    ),
                    createCard(21, 25, _onNumberTap, numberSelectedCount),
                  ],
                ),
              ),
              Padding(
                child: Text(
                  message,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.only(top: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget createCard(int initialNumber, int endNumber, Function onNumberTap,
    int numberSelectedCount) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:
        ballRow(initialNumber, endNumber, onNumberTap, numberSelectedCount),
  );
}

List<Widget> ballRow(int initialNumber, int endNumber, Function onNumberTap,
    int numberSelectedCount) {
  List<Widget> balls = new List<Widget>();
  for (int i = initialNumber; i <= endNumber; i++) {
    String ballNumber = NumberUtils().formatBallNumber(i);

    balls.add(Ball(ballNumber, onNumberTap, numberSelectedCount));
  }
  return balls;
}
