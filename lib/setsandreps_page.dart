import 'package:flutter/material.dart';
import 'setsandreps_widget.dart';
import 'save_state.dart';
import 'calc.dart';

// This page displays the sets and reps for daily workout and warmup
class SetsAndRepsPage extends StatelessWidget {
  SetsAndRepsPage({
    Key key,
    this.activity,
  }) : super(key: key);

  final String activity;

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Today's sets and reps for $activity"),
      ),
      body: ListView(
        children: <Widget>[
          SetsAndReps(
            argTitle: Calc.getWarmup(SaveStateHelper.getMaxRep(activity), 1),
            subTitle: "    Warmup set 1",
          ),
          SizedBox(height: 15.0),
          SetsAndReps(
            argTitle: Calc.getWarmup(SaveStateHelper.getMaxRep(activity), 2),
            subTitle: "    Warmup set 2",
          ),
          SizedBox(height: 15.0),
          SetsAndReps(
            argTitle: Calc.getWarmup(SaveStateHelper.getMaxRep(activity), 3),
            subTitle: "    Warmup set 3",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.done_all),
        label: Text("Done"),
        backgroundColor: Colors.red[400],
      ),
    );
  }
}
