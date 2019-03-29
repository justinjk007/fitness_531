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
      body: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        border: TableBorder.all(width: 1, color: Colors.grey),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Text("This is first test"),
              ),
              TableCell(
                child: Text("This is second test"),
              ),
            ], // End of row 1
          ),
          TableRow(
            children: [
              TableCell(
                child: Text("This is third test"),
              ),
              TableCell(
                child: Text("This is fourth test"),
              ),
            ], // End of row 2
          ),
        ], // End of tables children
      ),
      // body: new RaisedButton(
      //   padding: const EdgeInsets.all(8.0),
      //   textColor: Colors.white,
      //   color: Colors.blue,
      //   onPressed: () {
      //     saveData();
      //   },
      //   child: new Text("Click to notify parent!"),
      // ),
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
