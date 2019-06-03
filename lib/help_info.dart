import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter/material.dart';

class HelpInfo {
  static Widget syncProblemWidget(BuildContext ctxt) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          Icon(OMIcons.cloudOff, size: 40, color: Theme.of(ctxt).hintColor),
          Text("Sync_problem!",
              style: TextStyle(color: Theme.of(ctxt).hintColor)),
        ],
      ),
    );
  }

  static Widget centerCircularProgressIndicator() {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  static Widget pleaseLoginWidget(BuildContext ctxt) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          Icon(OMIcons.accountCircle, size: 40, color: Theme.of(ctxt).hintColor),
          Text("Please login!",
              style: TextStyle(color: Theme.of(ctxt).hintColor)),
        ],
      ),
    );
  }
}
