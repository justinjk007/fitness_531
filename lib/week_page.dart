import 'package:flutter/material.dart';
import 'side_drawer.dart';
import 'week_widget.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      drawer: new SideDrawer(),
      appBar: new AppBar(title: new Text("Select week in your routine")),
      body: new Column(
        children: <Widget>[
          new Weeks(
            weekID: 'week1',
            argTitle: new Text("\nWeek 1"),
            subTitle: new Text(
                "\n3 sets of 5 reps\n\n65% x 5     75% x 5     85% x 5"),
          ),
          new Weeks(
            weekID: 'week2',
            argTitle: new Text("\nWeek 2"),
            subTitle: new Text(
                "\n3 sets of 3 reps\n\n70% x 3     80% x 3     90% x 3"),
          ),
          new Weeks(
            weekID: 'week3',
            argTitle: new Text("\nWeek 3"),
            subTitle: new Text(
                "\n3 sets of 5/3/1 reps\n\n75% x 5     85% x 3     95% x 1"),
          ),
          new Weeks(
            weekID: 'week4',
            argTitle: new Text("\nWeek 4"),
            subTitle:
                new Text("\nDeload week\n\n40% x 5     50% x 5     60% x 5"),
          ),
        ], // List of cards end here
      ),
    );
  }
}