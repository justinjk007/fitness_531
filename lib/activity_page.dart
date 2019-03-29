import 'package:flutter/material.dart';
import 'save_state.dart';

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
        title: new Text("Select today's activity!"),
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
                Expanded(
                  child: Material(
                    color: Colors.purple[200],
                    elevation: 4.0,
                    child: Ink.image(
                      image: AssetImage('assets/squat.png'),
                      // fit: BoxFit.cover,
                      width: 120.0,
                      height: 300.0,
                      child: InkWell(
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Material(
                    color: Colors.blue[200],
                    elevation: 4.0,
                    child: Ink.image(
                      image: AssetImage('assets/bench.png'),
                      // fit: BoxFit.cover,
                      width: 120.0,
                      height: 300.0,
                      child: InkWell(
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: Colors.green[200],
                    elevation: 4.0,
                    child: Ink.image(
                      image: AssetImage('assets/deadlift.png'),
                      // fit: BoxFit.cover,
                      width: 120.0,
                      height: 300.0,
                      child: InkWell(
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Material(
                    color: Colors.yellow[200],
                    elevation: 4.0,
                    child: Ink.image(
                      image: AssetImage('assets/press.png'),
                      // fit: BoxFit.cover,
                      width: 120.0,
                      height: 300.0,
                      child: InkWell(
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// // class for each exercise to be done
// class Activity extends StatefulWidget {
//   _ActivityState createState() => _ActivityState();
// }

// class _ActivityState extends State<Activity> {
//   void notifyReceiver() {
//     setState(() {
//       // Empty method just to refresh widget, collecting new data is handled by
//       // FutureBuilder. It gets data from memory and loads a default if it
//       // doens't find any
//     });
//   }
// }
