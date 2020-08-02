import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  final String ballNumber;
  Function onNumberTap;

  Ball(this.ballNumber, this.onNumberTap);

  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  Color color = Colors.white;
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
        onTap: () {
          setState(() {
            color = color == Colors.white ? Colors.greenAccent : Colors.white;
            widget.onNumberTap(widget.ballNumber, color == Colors.greenAccent);
          });
        },
        child: new Text(
          widget.ballNumber,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }
}
