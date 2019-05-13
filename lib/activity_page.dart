import 'package:flutter/material.dart';
import 'activity_widget.dart';

// This is the page where the four activities of the week are displayed
class ActivityPage extends StatelessWidget {
  // final Function notifyParent;
  final String weekIDForChild;
  ActivityPage({
    Key key,
    // @required this.notifyParent,
    @required this.weekIDForChild,
  }) : super(key: key);

  // void saveData() async {
  //   notifyParent();
  // }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Select today's activity"),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
          top: MediaQuery.of(ctxt).size.height / 20,
          bottom: MediaQuery.of(ctxt).size.height / 20,
        ),
        child: new Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                new Activity(
                  image: 'assets/squat.png',
                  color: Colors.red[50],
                  activity: 'squat',
                  weekID: weekIDForChild,
                ),
                SizedBox(width: 10.0),
                new Activity(
                  image: 'assets/bench.png',
                  color: Colors.red[50],
                  activity: 'bench',
                  weekID: weekIDForChild,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                new Activity(
                  image: 'assets/deadlift.png',
                  color: Colors.red[50],
                  activity: 'deadlift',
                  weekID: weekIDForChild,
                ),
                SizedBox(width: 10.0),
                new Activity(
                  image: 'assets/press.png',
                  color: Colors.red[50],
                  activity: 'press',
                  weekID: weekIDForChild,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
