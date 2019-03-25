import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For reading and writing data to disk with ease

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: new FirstScreen(),
    );
  }
}

Future<void> saveWeekState(String weekNum, bool state) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(weekNum, state); // Example("week1",true) , true means active
}

Future<bool> getWeekState(String weekNum) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool state =
      prefs.getBool(weekNum); // Example("week1",true) , true means active
  return state;
}

class Weeks extends StatefulWidget {
  Weeks({
    Key key,
    this.argTitle,
    this.subTitle,
    this.cardIcon,
    this.weekNum,
  }) : super(key: key);

  final Widget argTitle;
  final Widget subTitle;
  final Icon cardIcon;
  final int weekNum;
  @override
  _WeekWidgetState createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<Weeks> {
  String _text = 'active'; // By default each week us active
  bool week1;

  void getData() async {
    week1 = await getWeekState('week1');
    print("GETTING DATA from memory");
  }

  void refresh() {
    setState(() {
      if (week1) {
        _text = 'active';
      } else {
        _text = 'inactive';
      }
    });
  }

  Widget _getNextScreen() {
    Widget nextScreen = new SecondScreen();
    if (widget.weekNum == 3) {
      nextScreen = new ThirdScreen(notifyParent: refresh);
    }
    return nextScreen;
  }

  @override
  Widget build(BuildContext ctxt) {
    return (new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: new SizedBox(
        width: double.infinity,
        height: 144.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
              ctxt,
              new MaterialPageRoute(builder: (ctxt) => _getNextScreen()),
            );
          },
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: widget.cardIcon,
                  title: widget.argTitle,
                  subtitle: Text(_text),
                ),
              ], // End of list
            ),
          ),
        ),
      ),
    ));
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Select week in your routine")),
      body: new Column(
        children: <Widget>[
          new Weeks(
            argTitle: new Text("Week 1"),
            // subTitle: new Text("3 sets of 5 reps"),
            subTitle: new Text("active"),
            cardIcon: new Icon(Icons.looks_one, color: Colors.red, size: 50.0),
          ),
          new Weeks(
            argTitle: new Text("Week 2"),
            // subTitle: new Text("3 sets of 3 reps"),
            subTitle: new Text("active"),
            cardIcon: new Icon(Icons.looks_two, color: Colors.red, size: 50.0),
          ),
          new Weeks(
            argTitle: new Text("Week 3"),
            // subTitle: new Text("5/3/1 sets"),
            subTitle: new Text("active"),
            cardIcon: new Icon(Icons.looks_3, color: Colors.red, size: 50.0),
            weekNum: 3,
          ),
          new Weeks(
            argTitle: new Text("Week 4"),
            // subTitle: new Text("Deload week"),
            subTitle: new Text("active"),
            cardIcon: new Icon(Icons.looks_4, color: Colors.red, size: 50.0),
          ),
        ], // List of cards end here
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Multi Page Application Page 2"),
      ),
      body: new Text("Another Page...!!!!!!"),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  final Function() notifyParent;
  ThirdScreen({Key key, @required this.notifyParent}) : super(key: key);

  void saveData() {
    saveWeekState("week1", false);
    print("Week1 is set to false");
    notifyParent();
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Multi Page Application Page 3"),
      ),
      body: new RaisedButton(
        padding: const EdgeInsets.all(8.0),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          saveData();
        },
        child: new Text("Add"),
      ),
    );
  }
}
