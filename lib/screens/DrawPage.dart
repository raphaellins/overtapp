import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overtapp/api/Proxy.dart';
import 'package:overtapp/elements/Ball.dart';
import 'package:overtapp/models/NewGame.dart';
import 'package:overtapp/utils/NumberUtils.dart';

class DrawPage extends StatefulWidget {
  @override
  _DrawPageState createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
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

      _changeMessage("$numberSelectedCount numbers selected");
    });
  }

  TextEditingController initialGameController = new TextEditingController();
  TextEditingController gameDateController = new TextEditingController();
  TextEditingController descriptionGameController = new TextEditingController();

  _onFormSubmit() {
    FocusScope.of(context).unfocus();
    NewGame newGame = new NewGame(
        initialGameController.text,
        gameDateController.text,
        descriptionGameController.text,
        numbersSelected);

    if (newGame.initialGameNumber.isEmpty) {
      _changeMessage("Initial Game Number is required");
      return;
    } else if (int.tryParse(newGame.initialGameNumber) == null) {
      _changeMessage("Initial Game Number is invalid");
      return;
    }

    if (newGame.finalGameNumber.isEmpty) {
      _changeMessage("Final Game Number is required");
      return;
    } else if (int.tryParse(newGame.finalGameNumber) == null) {
      _changeMessage("Final Game Number is invalid");
      return;
    }

    if (int.parse(newGame.initialGameNumber) >
        int.parse(newGame.finalGameNumber)) {
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

    new Proxy().saveNewGame(newGame);

    _changeMessage("");
    _clearControllers();
  }

  _changeMessage(String newMessage) {
    setState(() {
      message = newMessage;
    });
  }

  _clearControllers() {
    initialGameController.clear();
    gameDateController.clear();
    descriptionGameController.clear();

    // setState(() {
    //   numberSelectedCount = 0;
    //   numbersSelected.clear();
    // });
  }

  _onDateChange(String newDate) {
    setState(() {
      gameDateController.text = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: _onFormSubmit,
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
                decoration: InputDecoration(hintText: "Draw Game Number"),
              ),
              TextField(
                readOnly: true,
                onTap: () {
                  showDialog(context, _onDateChange);
                },
                controller: gameDateController,
                decoration: InputDecoration(hintText: "Game Date"),
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

Widget openDataPicker(Function onDateChange) {
  return CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime.now(),
    onDateTimeChanged: (DateTime newDateTime) {
      onDateChange(DateFormat('dd/MM/yyyy').format(newDateTime));
    },
    use24hFormat: false,
    minuteInterval: 1,
  );
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

void showDialog(BuildContext context, Function onDateChange) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 300),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 300,
          child: openDataPicker(onDateChange),
          margin: EdgeInsets.only(bottom: 1, left: 1, right: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}
