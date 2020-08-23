import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overtapp/api/Proxy.dart';
import 'package:overtapp/controller/BallController.dart';
import 'package:overtapp/elements/Ball.dart';
import 'package:overtapp/models/NewDraw.dart';
import 'package:overtapp/utils/NumberUtils.dart';

class DrawPage extends StatefulWidget {
  @override
  _DrawPageState createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
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

  TextEditingController drawNumberController = new TextEditingController();
  TextEditingController gameDateController = new TextEditingController();

  _DrawPageState() {
    gameDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  _onFormSubmit() async {
    FocusScope.of(context).unfocus();
    NewDraw newDraw = new NewDraw(int.tryParse(drawNumberController.text),
        gameDateController.text, numbersSelected);

    if (newDraw.drawNumber == null) {
      _changeMessage("Draw Number is required");
      return;
    } else if (newDraw.drawNumber <= 0) {
      _changeMessage("Draw Number is invalid");
      return;
    }

    if (newDraw == null) {
      _changeMessage("The Draw date is required");
      return;
    }

    if (numberSelectedCount < 15) {
      _changeMessage("15 game numbers is required");
      return;
    }

    bool result = await new Proxy().saveNewDraw(newDraw);

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
    drawNumberController.clear();
    gameDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());

    ballController.reset();
    numberSelectedCount = 0;
    numbersSelected.clear();
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
                controller: drawNumberController,
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
    int numberSelectedCount, BallController ballController) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: ballRow(initialNumber, endNumber, onNumberTap,
        numberSelectedCount, ballController),
  );
}

List<Widget> ballRow(int initialNumber, int endNumber, Function onNumberTap,
    int numberSelectedCount, BallController ballController) {
  List<Widget> balls = new List<Widget>();
  for (int i = initialNumber; i <= endNumber; i++) {
    String ballNumber = NumberUtils().formatBallNumber(i);

    balls.add(
        Ball(ballNumber, onNumberTap, numberSelectedCount, ballController));
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 350,
              child: openDataPicker(onDateChange),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 1),
              padding: EdgeInsets.only(right: 22),
              child: FlatButton(
                child: actionDetail(),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              color: Colors.white,
            )
          ],
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

Widget actionDetail() {
  String actionLabel = "Done";
  return Align(
    alignment: Alignment.bottomRight,
    child: Text(
      actionLabel,
      textAlign: TextAlign.right,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    ),
  );
}
