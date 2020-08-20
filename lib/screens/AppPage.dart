import 'package:flutter/material.dart';

class AppPage {
  AppPage(
      {Widget icon, Text title, Color color, this.body, TickerProvider vsync})
      : this._title = title.data,
        this._color = color,
        this.controller = new AnimationController(
            vsync: vsync, duration: Duration(milliseconds: 300)),
        this.item = new BottomNavigationBarItem(
          icon: icon,
          title: title,
          backgroundColor: color,
        ) {
    _animation =
        new CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
  }

  final String _title;
  final Color _color;
  final AnimationController controller;
  final BottomNavigationBarItem item;
  final Widget body;
  CurvedAnimation _animation;

  FadeTransition buildTransition(BuildContext context) {
    return new FadeTransition(
      opacity: _animation,
      child: body,
    );
  }
}
