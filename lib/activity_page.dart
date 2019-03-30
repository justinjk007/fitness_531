import 'package:flutter/material.dart';
import 'save_state.dart';
import 'activity_widget.dart';
import 'setsandreps_page.dart';

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

  Widget _getNextScreen() {
    Widget nextScreen = new SetsAndRepsPage();
    return nextScreen;
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Select today's activity"),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 40,
          right: 40,
          top: 50,
          bottom: 50,
        ),
        child: new Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                new Activity(
                  action: () {
                    Navigator.push(
                      ctxt,
                      new MaterialPageRoute(
                          builder: (ctxt) => _getNextScreen()),
                    );
                  },
                  image: 'assets/squat.png',
                  color: Colors.red[50],
                ),
                SizedBox(width: 10.0),
                new Activity(
                  action: saveData,
                  image: 'assets/bench.png',
                  color: Colors.red[50],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                new Activity(
                  action: saveData,
                  image: 'assets/deadlift.png',
                  color: Colors.red[50],
                ),
                SizedBox(width: 10.0),
                new Activity(
                  action: saveData,
                  image: 'assets/press.png',
                  color: Colors.red[50],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
