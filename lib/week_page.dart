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

  // TODO: Add a circle avatar button that diplays user image when signed in and show dialog box to sign out if clicked after signing in
  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      drawer: SideDrawer(callBackWeeksPage: this.update),
      appBar: AppBar(
        title: Text("Select week in your routine"),
        actions: <Widget>[
          new Builder(builder: (BuildContext ctxt) {
            return IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () async {
                const _pass_msg = SnackBar(content: Text('Signed with google'));
                const _fail_msg = SnackBar(content: Text('Signing in failed!'));
                bool _isLoggedIN = await _loginUser();
                _isLoggedIN
                    ? Scaffold.of(ctxt).showSnackBar(_pass_msg)
                    : Scaffold.of(ctxt).showSnackBar(_fail_msg);
              },
            );
          }),
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
