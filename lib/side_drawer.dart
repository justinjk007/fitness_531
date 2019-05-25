import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter/material.dart';
import 'new_records.dart';
import 'about_page.dart';
import 'records.dart';
import 'save_state.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({
    Key key,
    this.callBackWeeksPage,
  }) : super(key: key);

  final Function callBackWeeksPage;

  @override
  Widget build(BuildContext ctxt) {
    // user defined function
    void _showResetDialog() {
      // flutter defined function
      showDialog(
        context: ctxt,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Start a new streak"),
            // TODO: This shape is legacy after upgrading flutter, so find a workaround
            // shape: SuperellipseShape(
            //   borderRadius: BorderRadius.circular(20.0),
            // ),
            content: Text("This will reset all the activity status of "
                "all weeks, this means you are starting a new 4 week streak..."),
            actions: <Widget>[
              // Usually buttons at the bottom of the dialog
              FlatButton(
                child: Text(
                  "Yep, Reset!",
                  style: TextStyle(
                    fontStyle: FontStyle.italic, // yeyya!
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  SaveStateHelper.resetAll().then((_) {
                    callBackWeeksPage();
                  });
                  // Exit out of the window after reseting
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 10), // Add a little bit of padding after
            ], // Actions ends here
          );
        },
      );
    }

    return new Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Text(
                  '\n5/3/1 Fitness',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/barbell_raw.png',
                  height: 60,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            // decoration: BoxDecoration(
            //   color: Colors.red[200],
            // ),
          ),
          ListTile(
            leading: Icon(OMIcons.assignment, color: Colors.red[400], size: 30),
            title: Text('Records'),
            onTap: () {
              Navigator.pop(ctxt); // Close the drawer first
              Navigator.push(
                ctxt,
                new MaterialPageRoute(
                    builder: (ctxt) => new FirestoreCRUDPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(OMIcons.assignment, color: Colors.red[400], size: 30),
            title: Text('Old records'),
            onTap: () {
              Navigator.pop(ctxt); // Close the drawer first
              Navigator.push(
                ctxt,
                new MaterialPageRoute(
                    builder: (ctxt) => new RecordsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(OMIcons.timelapse, color: Colors.red[400], size: 30),
            title: Text('Start a new streak'),
            onTap: () {
              Navigator.pop(ctxt); // Close the drawer first
              _showResetDialog(); // Show the reset dialog
            },
          ),
          ListTile(
            leading: Icon(OMIcons.brightness2, color: Colors.red[400], size: 30),
            title: Text('Dark Mode'),
            trailing: Switch(
              // activeTrackColor: Colors.lightGreenAccent,
              // activeColor: Colors.green,
              value:
                  Theme.of(ctxt).brightness == Brightness.dark ? true : false,
              onChanged: (value) {
                DynamicTheme.of(ctxt).setBrightness(
                    Theme.of(ctxt).brightness == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark);
              },
            ),
          ),
          ListTile(
            leading: Icon(OMIcons.info, color: Colors.red[400], size: 30),
            title: Text('About'),
            onTap: () {
              Navigator.pop(ctxt); // Close the drawer first
              Navigator.push(
                ctxt,
                new MaterialPageRoute(builder: (ctxt) => new AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
