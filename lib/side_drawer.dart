import 'package:flutter/material.dart';
import 'about_page.dart';
import 'records.dart';
import 'save_state.dart';

class SideDrawer extends StatelessWidget {
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
            shape: SuperellipseShape(
              borderRadius: BorderRadius.circular(20.0),
            ),
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
                  SaveStateHelper.resetAll();
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
            child: Text(
              '\n5/3/1 Fitness',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            decoration: BoxDecoration(
              color: Colors.red[200],
            ),
          ),
          ListTile(
            leading: Icon(Icons.tune, color: Colors.red[400], size: 30),
            title: Text('Set 1RM records'),
            onTap: () {
              Navigator.pop(ctxt); // Close the drawer first
              Navigator.push(
                ctxt,
                new MaterialPageRoute(builder: (ctxt) => new RecordsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.timelapse, color: Colors.red[400], size: 30),
            title: Text('Start a new streak'),
            onTap: () {
              Navigator.pop(ctxt); // Close the drawer first
              _showResetDialog(); // Show the reset dialog
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.red[400], size: 30),
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
