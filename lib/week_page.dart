import 'package:flutter/material.dart';
import 'auth.dart'; // To sign in with Google
import 'side_drawer.dart';
import 'week_widget.dart';

class WeekPage extends StatelessWidget {
  Future<bool> _loginUser() async {
    final api = await FBApi.signInWithGoogle();
    if (api != null) {
      return true;
    } else {
      return false;
    }
  }

  Weeks week1 = new Weeks(
    weekID: 'week1',
    argTitle: new Text("\nWeek 1"),
    subTitle: new Text("\n3 sets of 5 reps\n\n65% x 5     75% x 5     85% x 5"),
  );
  Weeks week2 = new Weeks(
    weekID: 'week2',
    argTitle: new Text("\nWeek 2"),
    subTitle: new Text("\n3 sets of 3 reps\n\n70% x 3     80% x 3     90% x 3"),
  );
  Weeks week3 = new Weeks(
    weekID: 'week3',
    argTitle: new Text("\nWeek 3"),
    subTitle:
        new Text("\n3 sets of 5/3/1 reps\n\n75% x 5     85% x 3     95% x 1"),
  );
  Weeks week4 = new Weeks(
    weekID: 'week4',
    argTitle: new Text("\nWeek 4"),
    subTitle: new Text("\nDeload week\n\n40% x 5     50% x 5     60% x 5"),
  );

  void update() {
    week1.update();
    week2.update();
    week3.update();
    week4.update();
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      drawer: new SideDrawer(callBackWeeksPage: this.update),
      appBar: new AppBar(
        title: new Text("Select week in your routine"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () async {
              bool _isLoggedIN = await _loginUser();
              // May be use snackBar btw
              // _isLoggedIN
              //     ? // That worked, take care of this
              //     : // That didn't work, take care of that
            },
          ),
        ],
      ),
      body: new ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          week1,
          week2,
          week3,
          week4,
        ], // List of cards end here
      ),
    );
  }
}
