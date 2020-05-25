import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class HelpInfo {
  static Widget syncProblemWidget(BuildContext ctxt) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 50), // padding
          SvgPicture.asset(
            'assets/undraw_server_cluster.svg',
            height: MediaQuery.of(ctxt).size.height / 2.5,
            width: MediaQuery.of(ctxt).size.width / 2.5,
          ),
          const SizedBox(height: 50), // padding
          Text("Sync problem!",
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
          const SizedBox(height: 50), // padding
          SvgPicture.asset(
            'assets/undraw_memory_storage.svg',
            height: MediaQuery.of(ctxt).size.height / 2.5,
            width: MediaQuery.of(ctxt).size.width / 2.5,
          ),
          const SizedBox(height: 50), // padding
          Text("Please login to see your records",
              style: TextStyle(color: Theme.of(ctxt).hintColor)),
        ],
      ),
    );
  }
}
