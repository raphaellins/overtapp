import 'package:flutter/material.dart';
import 'package:overtapp/controller/BallController.dart';

class Ball extends StatefulWidget {
  final String ballNumber;
  final Function onNumberTap;
  final int numberSelectedCount;
  final BallController ballController;

  Ball(this.ballNumber, this.onNumberTap, this.numberSelectedCount,
      this.ballController);

  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  Color color = Colors.white;

  _onTapButton() {
    setState(() {
      if (widget.numberSelectedCount == 15) {
        if (color == Colors.greenAccent) {
          color = color == Colors.white ? Colors.greenAccent : Colors.white;
          widget.onNumberTap(widget.ballNumber, color == Colors.greenAccent);
        }
      } else if (widget.numberSelectedCount < 15) {
        color = color == Colors.white ? Colors.greenAccent : Colors.white;
        widget.onNumberTap(widget.ballNumber, color == Colors.greenAccent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.ballController.counterObservable
        .distinct()
        .listen((BallStateEnum ballState) {
      if (ballState == BallStateEnum.RESET) {
        color = Colors.white;
      }
    });

    return Container(
      width: 55,
      height: 55,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: GestureDetector(
        onTap: _onTapButton,
        child: Center(
            child: Text(
          widget.ballNumber,
          style: TextStyle(color: Colors.black, fontSize: 25),
        )),
      ),
    );
  }
}
