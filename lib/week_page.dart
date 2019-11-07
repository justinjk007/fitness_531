import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'auth.dart'; // To sign in with Google and check sign in status
import 'side_drawer.dart';
import 'week_widget.dart';

class WeekPage extends StatefulWidget {
  WeekPage({
    Key key,
  }) : super(key: key);

  final _WeekPageWidgetState state = new _WeekPageWidgetState();

  @override
  _WeekPageWidgetState createState() => state;
}

class _WeekPageWidgetState extends State<WeekPage> {
  String userPhotoUrl = "http://localhost";

  @override
  void initState() {
    super.initState();
    _getUserPhotoUrl();
  }

  void _getUserPhotoUrl() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      setState(() {
        userPhotoUrl = user.photoUrl.toString();
      });
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
    void _showLogoutDialog() {
      // flutter defined function
      showDialog(
        context: ctxt,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Do you want to logout?"),
            actions: <Widget>[
              // Usually buttons at the bottom of the dialog
              FlatButton(
                child: Text(
                  "Yes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  AuthHelper.logoutUser();
                  // Exit out of the window after reseting
                  setState(() {}); // Refresh page
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                onPressed: () {
                  // Exit out of the window to cancel
                  Navigator.of(context).pop();
                },
              ),
            ], // Actions ends here
          );
        },
      );
    }

    const double avatar_size = 15;
    return Scaffold(
      drawer: SideDrawer(callBackWeeksPage: this.update),
      appBar: AppBar(
        title: Text("Select week in your routine"),
        actions: <Widget>[
          new Builder(builder: (BuildContext ctxt) {
            Widget _loginButton = IconButton(
              icon: Icon(OMIcons.accountCircle),
              iconSize: avatar_size + 12,
              tooltip: 'Login with Google',
              onPressed: () async {
                const _pass_msg = SnackBar(content: Text('Signed with google'));
                const _fail_msg = SnackBar(content: Text('Signing in failed!'));
                bool _isLoggedIN = await AuthHelper.loginUser();
                setState(() {}); // Refresh page
                _isLoggedIN
                    ? Scaffold.of(ctxt).showSnackBar(_pass_msg)
                    : Scaffold.of(ctxt).showSnackBar(_fail_msg);
              },
            );

            Widget _logoutButton = InkWell(
              onTap: _showLogoutDialog,
              customBorder: CircleBorder(),
              child: Padding(
                // There is padding left and right so ripple effect looks better
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Center(
                  child: CircleAvatar(
                    radius: avatar_size,
                    backgroundImage: CachedNetworkImageProvider(userPhotoUrl),
                  ),
                ),
              ),
            );

            return FutureBuilder<bool>(
              future: AuthHelper.checkIfUserIsLoggedIn(),
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasError) {
                  return _loginButton;
                } else {
                  if (snapshot.data == true) {
                    return _logoutButton;
                  } else {
                    return _loginButton;
                  }
                }
              }, // End of  builder
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
