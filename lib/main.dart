import 'package:flutter/material.dart';

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

class Weeks extends StatelessWidget {
  Weeks({this.argTitle, this.subTitle, this.cardIcon, this.secondScreenName});
  final Widget argTitle;
  final Widget subTitle;
  final Icon cardIcon;
  final Widget secondScreenName;
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
              new MaterialPageRoute(builder: (ctxt) => secondScreenName),
            );
          },
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: cardIcon,
                  title: argTitle,
                  subtitle: subTitle,
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
            subTitle: new Text("3 sets of 5 reps"),
            cardIcon: new Icon(Icons.looks_one, color: Colors.blue, size: 50.0),
            secondScreenName: new ThirdScreen(),
          ),
          new Weeks(
            argTitle: new Text("Week 2"),
            subTitle: new Text("3 sets of 3 reps"),
            cardIcon: new Icon(Icons.looks_two, color: Colors.blue, size: 50.0),
            secondScreenName: new ThirdScreen(),
          ),
          new Weeks(
            argTitle: new Text("Week 3"),
            subTitle: new Text("5/3/1 sets"),
            cardIcon: new Icon(Icons.looks_3, color: Colors.blue, size: 50.0),
            secondScreenName: new SecondScreen(),
          ),
          new Weeks(
            argTitle: new Text("Week 4"),
            subTitle: new Text("Deload week"),
            cardIcon: new Icon(Icons.looks_4, color: Colors.blue, size: 50.0),
            secondScreenName: new SecondScreen(),
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
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Multi Page Application Page 3"),
      ),
      body: new Text("Another Page...!!!!!!"),
    );
  }
}
