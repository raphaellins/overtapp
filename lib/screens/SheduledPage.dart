import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overtapp/api/Auth.dart';
import 'package:overtapp/api/Proxy.dart';
import 'package:overtapp/models/GameDetail.dart';
import 'package:overtapp/models/NewGame.dart';
import 'package:provider/provider.dart';

class SheduledPage extends StatefulWidget {
  @override
  _SheduledPageState createState() => _SheduledPageState();
}

class _SheduledPageState extends State<SheduledPage> {
  List<GameDetail> _scheduledGames;

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
          (GameDetail a, GameDetail b) => a.gameNumber.compareTo(b.gameNumber));

      setState(() {
        _scheduledGames = copyData
            .where(
                (GameDetail gameDetail) => gameDetail.numbersDrawn.length == 0)
            .toList();
      });
    } catch (err) {
      print("Session expired");
      Provider.of<AuthService>(context).logout();
    }

    return;
  }

  _onRemove(GameDetail gameDetail) async {
    bool deleted = await new Proxy().delete(gameDetail.gameId);

    if (deleted) {
      await _retrieveData();
    }
  }

  _onDuplicate(GameDetail gameDetail, int gameNumber) async {
    NewGame newGame = new NewGame(gameNumber, gameNumber,
        gameDetail.gameDescription, gameDetail.numbersPlayed);

    await new Proxy().saveNewGame(newGame);

    await _retrieveData();
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
            itemCount: _scheduledGames == null ? 0 : _scheduledGames.length,
            itemBuilder: (context, index) {
              GameDetail gameDetail = _scheduledGames[index];
              return gameDetailItem(
                  context, gameDetail, _onRemove, _onDuplicate);
            },
          ),
          onRefresh: _retrieveData),
    );
  }
}

Widget gameDetailItem(BuildContext context, GameDetail gameDetail,
    Function onRemove, Function onDuplicate) {
  int newGameNumber;
  String gameNumber = gameDetail.gameNumber.toString();
  String gameDescription =
      gameDetail.gameDescription == null ? "" : gameDetail.gameDescription;

  return Dismissible(
    key: Key(gameDetail.gameId),
    confirmDismiss: (direction) async {
      String operationDescription;
      if (direction == DismissDirection.endToStart) {
        operationDescription = "Remove the game ${gameDetail.gameNumber}";
      } else {
        operationDescription = "Duplicate the game ${gameDetail.gameNumber}";
      }

      return await showDialogOperation(context, operationDescription,
          (String gameNumber) {
        newGameNumber = int.tryParse(gameNumber);
      }, null);
    },
    onDismissed: (direction) {
      String message;

      if (direction == DismissDirection.endToStart) {
        onRemove(gameDetail);
        message = "Game ${gameDetail.gameNumber} deleted";
      } else {
        onDuplicate(gameDetail, newGameNumber);
        message = "Game ${gameDetail.gameNumber} duplicated";
      }

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    },
    background: Container(
      color: Colors.blue,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Duplicate",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    ),
    secondaryBackground: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              "Remove",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        )),
    child: Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      height: 95,
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                gameInfo(gameNumber),
                gameInfo(gameDescription),
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
      ),
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

Widget gameInfo(String value) {
  return Text(value, style: TextStyle(color: Colors.black87));
}

showDialogOperation(BuildContext context, String operationDescription,
    Function onConfirmAction, Function onCancelAction) {
  TextEditingController gameNumberController = new TextEditingController();

  bool isDuplicate = operationDescription.contains("Duplicate");

  return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: new Text("Proceed with the action?"),
            content: Container(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  new Text(operationDescription),
                  SizedBox(
                    height: 10,
                  ),
                  isDuplicate
                      ? CupertinoTextField(
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          controller: gameNumberController,
                          placeholder: "Game Number Required",
                        )
                      : Container()
                ],
              ),
            )),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  if (isDuplicate) {
                    if (gameNumberController.text.isNotEmpty) {
                      onConfirmAction(gameNumberController.text);
                      Navigator.of(context).pop(true);
                    }
                  } else {
                    Navigator.of(context).pop(true);
                  }
                },
                isDefaultAction: true,
                child: Text("Confirm"),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Cancel"),
              )
            ],
          ));
}
