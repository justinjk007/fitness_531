import 'package:flutter/material.dart';
import 'setsandreps_widget.dart';

// This page displays the sets and reps for daily workout and warmup
class SetsAndRepsPage extends StatelessWidget {
  SetsAndRepsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Today's sets and reps"),
      ),
      body: ListView(
        children: <Widget>[
          SetsAndReps(),
          SetsAndReps(),
          SetsAndReps(),
          SetsAndReps(),
          SetsAndReps(),
          SetsAndReps(),
          SetsAndReps(),
          SetsAndReps(),
          SetsAndReps(),
          SetsAndReps(),
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
