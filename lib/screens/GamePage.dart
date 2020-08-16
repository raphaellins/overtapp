import 'package:flutter/material.dart';
import 'package:overtapp/api/Proxy.dart';
import 'package:overtapp/controller/BallController.dart';
import 'package:overtapp/elements/Ball.dart';
import 'package:overtapp/models/NewGame.dart';
import 'package:overtapp/utils/NumberUtils.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int numberSelectedCount = 0;
  String message = "";
  List<String> numbersSelected = new List<String>();

  BallController ballController = new BallController();

  _onNumberTap(String ballNumber, bool selected) {
    FocusScope.of(context).unfocus();
    setState(() {
      if (selected) {
        numbersSelected.add(ballNumber);
      } else {
        numbersSelected.remove(ballNumber);
      }
      numberSelectedCount = numbersSelected.length;

      _changeMessage("$numberSelectedCount numbers selected");
    });
  }

  TextEditingController initialGameController = new TextEditingController();
  TextEditingController finalGameController = new TextEditingController();
  TextEditingController descriptionGameController = new TextEditingController();

  _onFormSubmit() async {
    FocusScope.of(context).unfocus();
    NewGame newGame = new NewGame(
        int.tryParse(initialGameController.text),
        int.tryParse(finalGameController.text),
        descriptionGameController.text,
        numbersSelected);

    if (newGame.initialGameNumber == null) {
      _changeMessage("Initial Game Number is required");
      return;
    } else if (newGame.initialGameNumber <= 0) {
      _changeMessage("Initial Game Number is invalid");
      return;
    }

    if (newGame.finalGameNumber == null) {
      _changeMessage("Final Game Number is required");
      return;
    } else if (newGame.finalGameNumber <= 0) {
      _changeMessage("Final Game Number is invalid");
      return;
    }

    if (newGame.initialGameNumber > newGame.finalGameNumber) {
      _changeMessage("The Final Number must be less than Initial Game Number");
      return;
    }

    if (newGame.gameDescription.isEmpty) {
      _changeMessage("Description Game with 30 characters max is required");
      return;
    }

    if (numberSelectedCount < 15) {
      _changeMessage("15 game numbers is required");
      return;
    }

    bool result = await new Proxy().saveNewGame(newGame);

    if (result) {
      _changeMessage("");
      _clearControllers();
    } else {
      setState(() {
        _changeMessage("Ocorreu um erro!");
      });
    }
  }

  _changeMessage(String newMessage) {
    setState(() {
      message = newMessage;
    });
  }

  _clearControllers() {
    initialGameController.clear();
    finalGameController.clear();
    descriptionGameController.clear();

    ballController.reset();
    numberSelectedCount = 0;
    numbersSelected.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onFormSubmit();
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
                maxLength: 5,
                keyboardType: TextInputType.number,
                controller: initialGameController,
                decoration: InputDecoration(hintText: "Initial Game Number"),
              ),
              TextField(
                maxLength: 5,
                keyboardType: TextInputType.number,
                controller: finalGameController,
                decoration: InputDecoration(hintText: "Final Game Number"),
              ),
              TextField(
                maxLength: 15,
                controller: descriptionGameController,
                decoration: InputDecoration(hintText: "Game Description"),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    createCard(1, 5, _onNumberTap, numberSelectedCount,
                        ballController),
                    SizedBox(
                      height: 5,
                    ),
                    createCard(6, 10, _onNumberTap, numberSelectedCount,
                        ballController),
                    SizedBox(
                      height: 5,
                    ),
                    createCard(11, 15, _onNumberTap, numberSelectedCount,
                        ballController),
                    SizedBox(
                      height: 5,
                    ),
                    createCard(16, 20, _onNumberTap, numberSelectedCount,
                        ballController),
                    SizedBox(
                      height: 5,
                    ),
                    createCard(21, 25, _onNumberTap, numberSelectedCount,
                        ballController),
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
    int numberSelectedCount, ballController) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: ballRow(initialNumber, endNumber, onNumberTap,
        numberSelectedCount, ballController),
  );
}

List<Widget> ballRow(int initialNumber, int endNumber, Function onNumberTap,
    int numberSelectedCount, ballController) {
  List<Widget> balls = new List<Widget>();
  for (int i = initialNumber; i <= endNumber; i++) {
    String ballNumber = NumberUtils().formatBallNumber(i);

    balls.add(
        Ball(ballNumber, onNumberTap, numberSelectedCount, ballController));
  }
  return balls;
}
