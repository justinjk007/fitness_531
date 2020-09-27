import 'package:flutter/material.dart';
import 'activity_widget.dart';

// This is the page where the four activities of the week are displayed
class ActivityPage extends StatelessWidget {
  final String weekIDForChild;
  ActivityPage({
    Key key,
    @required this.weekIDForChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Select today's activity"),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 30),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2, // Number of rows
        childAspectRatio: 0.60, // Makes each rows bigger
        children: <Widget>[
          Activity(
            image: 'assets/squat.png',
            activity: 'squat',
            weekID: weekIDForChild,
          ),
          Activity(
            image: 'assets/bench.png',
            activity: 'bench',
            weekID: weekIDForChild,
          ),
          Activity(
            image: 'assets/deadlift.png',
            activity: 'deadlift',
            weekID: weekIDForChild,
          ),
          Activity(
            image: 'assets/press.png',
            activity: 'press',
            weekID: weekIDForChild,
          ),
        ],
      ),
    );
  }
}
