import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  final String ballNumber;
  final Function onNumberTap;
  final int numberSelectedCount;

  Ball(this.ballNumber, this.onNumberTap, this.numberSelectedCount);

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
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(),
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: GestureDetector(
        onTap: _onTapButton,
        child: new Text(
          widget.ballNumber,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }
}
