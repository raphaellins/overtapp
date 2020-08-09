import 'package:flutter/material.dart';
import 'package:overtapp/api/Auth.dart';
import 'package:overtapp/screens/AppPage.dart';
import 'package:overtapp/screens/DrawPage.dart';
import 'package:overtapp/screens/GamePage.dart';
import 'package:overtapp/screens/LoginPage.dart';
import 'package:overtapp/screens/MatchedPage.dart';
import 'package:overtapp/screens/SheduledPage.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider<AuthService>(
    child: MyApp(),
    builder: (BuildContext context) {
      return AuthService();
    }));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Overt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<UserState>(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot<UserState> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.userState == UserStateEnum.LOGGED) {
              return MyHomePage(title: 'Overt');
            } else if (snapshot.data.userState == UserStateEnum.EMPTY) {
              return LoginPage();
            } else {
              return LoadingCircle();
            }
          } else {
            return LoadingCircle();
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<AppPage> _items;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _items = [
      new AppPage(
          icon: new Icon(Icons.check_box_outline_blank),
          title: new Text(
            'Sheduled',
            style: TextStyle(color: Colors.white),
          ),
          color: Color.fromRGBO(26, 26, 25, 1),
          body: new SheduledPage(),
          vsync: this),
      new AppPage(
          icon: new Icon(Icons.check_box),
          title: new Text(
            'Matched',
            style: TextStyle(color: Colors.white),
          ),
          color: Color.fromRGBO(26, 26, 25, 1),
          body: new MatchedPage(),
          vsync: this),
      new AppPage(
          icon: new Icon(Icons.add_box),
          title: new Text(
            'New Game',
            style: TextStyle(color: Colors.white),
          ),
          color: Color.fromRGBO(26, 26, 25, 1),
          body: new GamePage(),
          vsync: this),
      new AppPage(
          icon: new Icon(Icons.assignment_turned_in),
          title: new Text(
            'New Draw',
            style: TextStyle(color: Colors.white),
          ),
          color: Color.fromRGBO(26, 26, 25, 1),
          body: new DrawPage(),
          vsync: this),
    ];

    for (AppPage view in _items) {
      view.controller.addListener(_rebuild);
    }

    _items[_currentIndex].controller.value = 1.0;
  }

  void _rebuild() {
    setState(() {});
  }

  Widget _buildPageStack() {
    final List<Widget> transitions = <Widget>[];

    for (int i = 0; i < _items.length; i++) {
      transitions.add(IgnorePointer(
          ignoring: _currentIndex != i,
          child: _items[i].buildTransition(context)));
    }
    return new Stack(children: transitions);
  }

  @override
  void dispose() {
    for (AppPage page in _items) {
      page.controller.dispose();
    }

    super.dispose();
  }

  void moveScreen(int pageIndex) {
    setState(() {
      _items[_currentIndex].controller.reverse();
      _currentIndex = pageIndex;
      _items[_currentIndex].controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar navBar = new BottomNavigationBar(
      items: _items.map((page) {
        return page.item;
      }).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
      onTap: (pageIndex) {
        moveScreen(pageIndex);
      },
    );

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: new Center(
        child: _buildPageStack(),
      ),
      bottomNavigationBar: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(child: navBar),
        ],
      ),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
