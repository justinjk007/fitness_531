import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For forcing device orientation
import 'week_widget.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(Colors.red.shade200.value, {
          50: Colors.red.shade50,
          100: Colors.red.shade100,
          200: Colors.red.shade200,
          300: Colors.red.shade300,
          400: Colors.red.shade400,
          500: Colors.red.shade500,
          600: Colors.red.shade600,
          700: Colors.red.shade700,
          800: Colors.red.shade800,
          900: Colors.red.shade900
        }),
      ),
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
