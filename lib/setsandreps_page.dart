import 'package:flutter/material.dart';
import 'setsandreps_widget.dart';
import 'save_state.dart';
import 'calc.dart';

// This page displays the sets and reps for daily workout and warmup
class SetsAndRepsPage extends StatelessWidget {
  SetsAndRepsPage({
    Key key,
    this.activity,
    this.weekID,
    this.notifyParent,
  }) : super(key: key);

  final String activity;
  final String weekID;
  final Function notifyParent; // Call back to notify if activity is complete

  void saveDataandRefreshParent() async {
    await SaveStateHelper.toggleActivity(weekID, activity);
    notifyParent();
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
        title: new Text("Today's sets for $activity"),
      ),
      body: ListView(
        children: <Widget>[
          CustomCard(
            argTitle: Calc.getWarmup(SaveStateHelper.getMaxRep(activity), 1),
            subTitle: "    Warmup set 1",
            setWeight: Calc.getWarmupVals(
              SaveStateHelper.getMaxRep(activity),
              1,
            )[0], // First index of the list is this sets weight
          ),
          CustomCard(
            argTitle: Calc.getWarmup(SaveStateHelper.getMaxRep(activity), 2),
            subTitle: "    Warmup set 2",
            setWeight: Calc.getWarmupVals(
              SaveStateHelper.getMaxRep(activity),
              2,
            )[0], // First index of the list is this sets weight
          ),
          CustomCard(
            argTitle: Calc.getWarmup(SaveStateHelper.getMaxRep(activity), 3),
            subTitle: "    Warmup set 3",
            setWeight: Calc.getWarmupVals(
              SaveStateHelper.getMaxRep(activity),
              3,
            )[0], // First index of the list is this sets weight
          ),
          CustomCard(
            argTitle:
                Calc.getRealSet(SaveStateHelper.getMaxRep(activity), 1, weekID),
            subTitle: "    Real $activity set 1",
            setWeight: Calc.getRealSetVals(
              SaveStateHelper.getMaxRep(activity),
              1,
              weekID,
            )[0], // First index of the list is this sets weight
          ),
          CustomCard(
            argTitle:
                Calc.getRealSet(SaveStateHelper.getMaxRep(activity), 2, weekID),
            subTitle: "    Real $activity set 2",
            setWeight: Calc.getRealSetVals(
              SaveStateHelper.getMaxRep(activity),
              2,
              weekID,
            )[0], // First index of the list is this sets weight
          ),
          CustomCard(
            argTitle:
                Calc.getRealSet(SaveStateHelper.getMaxRep(activity), 3, weekID),
            subTitle: "    Real $activity set 3",
            setWeight: Calc.getRealSetVals(
              SaveStateHelper.getMaxRep(activity),
              3,
              weekID,
            )[0], // First index of the list is this sets weight
          ),
          // CustomCard(
          //   argTitle: Calc.getAssistanceSet(
          //       SaveStateHelper.getMaxRep(getAssistanceActivity(activity))),
          //   subTitle: "    Assistance ${getAssistanceActivity(activity)} sets",
          // ),
          SizedBox(height: 60),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: saveDataandRefreshParent,
        icon: Icon(Icons.done_all),
        label: Text("Done"),
        tooltip: "Mark today's activities done !",
        backgroundColor: Colors.red[400],
      ),
    );
  }
}
