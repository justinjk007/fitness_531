import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'setsandreps_widget.dart';
import 'save_state.dart';
import 'query_helper.dart';
import 'calc.dart';

// This page displays the sets and reps for daily workout and warmup

// This page is Stateful because we need an initState method which will load the
// 1RM maxes for each activity already and save it in a global for the page to
// use instead of loading it from memory 10,000 times
class _SetsAndRepsPageState extends State<SetsAndRepsPage> {
  int _maxRep = 0; // Filled by _loadMaxRep
  int _assistanceMaxRep = 0; // Filled by _loadMaxRep
  int _activitiesDone = 0; // Used when dismissing cards, to count how many done

  @override
  void initState() {
    super.initState();
    _loadMaxRep(); // Load all the Max rep values from memory async
  }

  void _loadMaxRep() async {
    List<DocumentSnapshot> latestData =
        await QueryHelper.getMaxRepListFromDatabase();
    // latestData is list with only 1 item because the query is using limit(1) feature
    if (latestData != null) {
      setState(() {
        _maxRep = latestData[0].data[widget.activity];
        _assistanceMaxRep =
            latestData[0].data[getAssistanceActivity(widget.activity)];
      });
    }
  }

  void saveDataOnebyOneandRefreshParent(BuildContext _ctxt) async {
    _activitiesDone++;
    // If 3 warmup + 3 real + 1 assistance sets are done today is done boiiii
    if (_activitiesDone >= 7) {
      await SaveStateHelper.toggleActivity(widget.weekID, widget.activity);
      final snackBar = SnackBar(
        content: Text('Status saved!'),
      );
      // Find the Scaffold in the Widget tree and use it to show a SnackBar!
      Scaffold.of(_ctxt).showSnackBar(snackBar);
      widget.notifyParent();
    }
  }

  String getAssistanceActivity(String activity) {
    // Return the assistance activity done with a particular activity
    switch (activity) {
      case 'bench':
        return 'press';
      case 'press':
        return 'bench';
      case 'deadlift':
        return 'squat';
      case 'squat':
        return 'deadlift';
    }
    return 'This is impossible';
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Today's sets for ${widget.activity}"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          new Builder(builder: (BuildContext ctxt) {
            return Dismissible(
              // key needed if I actually want to remove this from backend
              key: ValueKey("null"),
              onDismissed: (direction) {
                // I don't  care about direction here
                saveDataOnebyOneandRefreshParent(ctxt);
              },
              background: Align(
                alignment: Alignment(-0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              secondaryBackground: Align(
                alignment: Alignment(0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              child: CustomCard(
                argTitle: Calc.getWarmup(_maxRep, 1),
                subTitle: "Warmup set 1",
                setWeight: Calc.getWarmupVals(
                  _maxRep,
                  1,
                )[0], // First index of the list is this sets weight
              ),
            );
          }),
          new Builder(builder: (BuildContext ctxt) {
            return Dismissible(
              // key needed if I actually want to remove this from backend
              key: ValueKey("null"),
              onDismissed: (direction) {
                // I don't  care about direction here
                saveDataOnebyOneandRefreshParent(ctxt);
              },
              background: Align(
                alignment: Alignment(-0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              secondaryBackground: Align(
                alignment: Alignment(0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              child: CustomCard(
                argTitle: Calc.getWarmup(_maxRep, 2),
                subTitle: "Warmup set 2",
                setWeight: Calc.getWarmupVals(
                  _maxRep,
                  2,
                )[0], // First index of the list is this sets weight
              ),
            );
          }),
          new Builder(builder: (BuildContext ctxt) {
            return Dismissible(
              // key needed if I actually want to remove this from backend
              key: ValueKey("null"),
              onDismissed: (direction) {
                // I don't  care about direction here
                saveDataOnebyOneandRefreshParent(ctxt);
              },
              background: Align(
                alignment: Alignment(-0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              secondaryBackground: Align(
                alignment: Alignment(0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              child: CustomCard(
                argTitle: Calc.getWarmup(_maxRep, 3),
                subTitle: "Warmup set 3",
                setWeight: Calc.getWarmupVals(
                  _maxRep,
                  3,
                )[0], // First index of the list is this sets weight
              ),
            );
          }),
          new Builder(builder: (BuildContext ctxt) {
            return Dismissible(
              // key needed if I actually want to remove this from backend
              key: ValueKey("null"),
              onDismissed: (direction) {
                // I don't  care about direction here
                saveDataOnebyOneandRefreshParent(ctxt);
              },
              background: Align(
                alignment: Alignment(-0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              secondaryBackground: Align(
                alignment: Alignment(0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              child: CustomCard(
                argTitle: Calc.getRealSet(_maxRep, 1, widget.weekID),
                subTitle: "Real ${widget.activity} set 1",
                setWeight: Calc.getRealSetVals(
                  _maxRep,
                  1,
                  widget.weekID,
                )[0], // First index of the list is this sets weight
              ),
            );
          }),
          new Builder(builder: (BuildContext ctxt) {
            return Dismissible(
              // key needed if I actually want to remove this from backend
              key: ValueKey("null"),
              onDismissed: (direction) {
                // I don't  care about direction here
                saveDataOnebyOneandRefreshParent(ctxt);
              },
              background: Align(
                alignment: Alignment(-0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              secondaryBackground: Align(
                alignment: Alignment(0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              child: CustomCard(
                argTitle: Calc.getRealSet(_maxRep, 2, widget.weekID),
                subTitle: "Real ${widget.activity} set 2",
                setWeight: Calc.getRealSetVals(
                  _maxRep,
                  2,
                  widget.weekID,
                )[0], // First index of the list is this sets weight
              ),
            );
          }),
          new Builder(builder: (BuildContext ctxt) {
            return Dismissible(
              // key needed if I actually want to remove this from backend
              key: ValueKey("null"),
              onDismissed: (direction) {
                // I don't  care about direction here
                saveDataOnebyOneandRefreshParent(ctxt);
              },
              background: Align(
                alignment: Alignment(-0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              secondaryBackground: Align(
                alignment: Alignment(0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              child: CustomCard(
                argTitle: Calc.getRealSet(_maxRep, 3, widget.weekID),
                subTitle: "Real ${widget.activity} set 3",
                setWeight: Calc.getRealSetVals(
                  _maxRep,
                  3,
                  widget.weekID,
                )[0], // First index of the list is this sets weight
              ),
            );
          }),
          new Builder(builder: (BuildContext ctxt) {
            return Dismissible(
              // key needed if I actually want to remove this from backend
              key: ValueKey("null"),
              onDismissed: (direction) {
                // I don't  care about direction here
                saveDataOnebyOneandRefreshParent(ctxt);
              },
              background: Align(
                alignment: Alignment(-0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              secondaryBackground: Align(
                alignment: Alignment(0.8, 0), // Axix goes from 1 to -1
                child: Icon(Icons.done_all),
              ),
              child: CustomCard(
                argTitle: Calc.getAssistanceSet(_assistanceMaxRep),
                subTitle:
                    "Assisting ${getAssistanceActivity(widget.activity)} sets",
                setWeight: Calc.getAssistanceSetVals(_assistanceMaxRep),
              ),
            );
          }),
        ],
      ),
      // // Here floatingActionButton is built inside a builder because we need to
      // // give the snackBar a context which will be later used to find the
      // // Scaffold under which the SnackBar should be displayed
      // floatingActionButton: new Builder(builder: (BuildContext ctxt) {
      //   return FloatingActionButton.extended(
      //     onPressed: () {
      //       saveDataandRefreshParent(); // save data before showing snackBar
      //       final snackBar = SnackBar(
      //         content: Text('Status saved!'),
      //         action: SnackBarAction(
      //           label: 'Undo',
      //           onPressed: () {
      //             // Some code to undo the change!
      //             // save data, essentially toggling/undoing the status
      //             saveDataandRefreshParent();
      //           },
      //         ),
      //       );
      //       // Find the Scaffold in the Widget tree and use it to show a SnackBar!
      //       Scaffold.of(ctxt).showSnackBar(snackBar);
      //     },
      //     icon: Icon(Icons.done_all),
      //     label: Text("Done"),
      //     tooltip: "Mark today's activities done !",
      //     backgroundColor: Colors.red[400],
      //   );
      // }),
    );
  }
}

class SetsAndRepsPage extends StatefulWidget {
  SetsAndRepsPage({
    Key key,
    this.activity,
    this.weekID,
    this.notifyParent,
  }) : super(key: key);

  final String activity;
  final String weekID;
  final Function notifyParent; // Call back to notify if activity is complete

  @override
  _SetsAndRepsPageState createState() => _SetsAndRepsPageState();
}
