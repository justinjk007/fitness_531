import 'package:flutter/material.dart';
import 'setsandreps_widget.dart';

class OneRepMaxPage extends StatelessWidget {
  final int squat_max;
  final int bench_max;
  final int deadlift_max;
  final int press_max;
  OneRepMaxPage({
    Key key,
    @required this.squat_max,
    @required this.bench_max,
    @required this.deadlift_max,
    @required this.press_max,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("One rep maxes"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          CustomCard(
            argTitle: "$squat_max",
            subTitle: "Squat",
            setWeight: squat_max.toDouble(),
          ),
          CustomCard(
            argTitle: "$bench_max",
            subTitle: "Bench",
            setWeight: bench_max.toDouble(),
          ),
          CustomCard(
            argTitle: "$deadlift_max",
            subTitle: "Deadlift",
            setWeight: deadlift_max.toDouble(),
          ),
          CustomCard(
            argTitle: "$press_max",
            subTitle: "Press",
            setWeight: press_max.toDouble(),
          )
        ],
      ),
    );
  }
}
