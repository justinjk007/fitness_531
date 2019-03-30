import 'package:flutter/material.dart';
import 'save_state.dart';
import 'activity_widget.dart';

// This is the page where the four activities of the week are displayed
class ActivityPage extends StatelessWidget {
  final Function() notifyParent;
  final String weekIDForChild;
  ActivityPage({
    Key key,
    @required this.notifyParent,
    @required this.weekIDForChild,
  }) : super(key: key);

  void saveData() async {
    await SaveStateHelper.toggleWeek(weekIDForChild);
    notifyParent();
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Select today's activity"),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 40.0,
          right: 40.0,
          top: 50,
          bottom: 50,
        ),
        child: new Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                new Activity(
                  action: saveData,
                  image: 'assets/squat.png',
                  color: Colors.purple[200],
                ),
                SizedBox(width: 10.0),
                new Activity(
                  action: saveData,
                  image: 'assets/bench.png',
                  color: Colors.green[200],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                new Activity(
                  action: saveData,
                  image: 'assets/deadlift.png',
                  color: Colors.blue[200],
                ),
                SizedBox(width: 10.0),
                new Activity(
                  action: saveData,
                  image: 'assets/press.png',
                  color: Colors.yellow[200],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
