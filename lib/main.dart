import 'package:flutter/material.dart';
import 'week_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: new FirstScreen(),
    );
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
            weekID: 'week1',
            argTitle: new Text("Week 1"),
            subTitle:
                new Text("3 sets of 5 reps\n\n65% x 5     75% x 5     85% x 5"),
          ),
          new Weeks(
            weekID: 'week2',
            argTitle: new Text("Week 2"),
            subTitle:
                new Text("3 sets of 3 reps\n\n70% x 3     80% x 3     90% x 3"),
          ),
          new Weeks(
            weekID: 'week3',
            argTitle: new Text("Week 3"),
            subTitle: new Text(
                "3 sets of 5/3/1 reps\n\n75% x 5     85% x 3     95% x 1"),
          ),
          new Weeks(
            weekID: 'week4',
            argTitle: new Text("Week 4"),
            subTitle:
                new Text("Deload week\n\n40% x 5     50% x 5     60% x 5"),
          ),
        ], // List of cards end here
      ),
    );
  }
}

