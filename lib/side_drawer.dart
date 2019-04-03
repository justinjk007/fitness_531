import 'package:flutter/material.dart';
import 'about_page.dart';
import 'records.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
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
              Navigator.push(
                ctxt,
                new MaterialPageRoute(builder: (ctxt) => new RecordsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.red[400], size: 30),
            title: Text('About'),
            onTap: () {
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
