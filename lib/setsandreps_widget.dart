import 'package:flutter/material.dart';
import 'save_state.dart';

class SetsAndReps extends StatelessWidget {
  SetsAndReps({
    Key key,
    this.argTitle,
    this.subTitle,
  }) : super(key: key);

  final String argTitle;
  final String subTitle;

  @override
  Widget build(BuildContext ctxt) {
    return ListTile(
      title: Text(
        argTitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          color: Colors.red[200],
        ),
      ),
    );
  }
}
