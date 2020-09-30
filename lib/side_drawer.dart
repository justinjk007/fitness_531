import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter/material.dart';
import 'plate_selection_chips.dart';
import 'new_records.dart';
import 'about_page.dart';
import 'save_state.dart';
import 'helper.dart';

class _SideDrawerState extends State<SideDrawer> {
  double _barWeight;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SaveStateHelper.getBarWeight().then(
      (data) => setState(() {
        _barWeight = data;
      }),
    );
  }

  // user defined function
  void _showResetDialog(BuildContext ctxt) {
    // flutter defined function
    showDialog(
      context: ctxt,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Start a new streak"),
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
                  widget.callBackWeeksPage();
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

  @override
  Widget build(BuildContext ctxt) {
    final bool _isIOS = Theme.of(ctxt).platform == TargetPlatform.iOS;

    // user defined function, since this function requires to know if the
    // devices context it needs to be rebuild along with the page
    void _showBarWeightDialog(BuildContext ctxt) {
      // flutter defined function
      showDialog(
        context: ctxt,
        builder: (ctxt) {
          return AlertDialog(
            title: Text('Set bar weight'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                onSaved: (input) => _barWeight = double.parse(input),
                decoration: InputDecoration(
                  prefixIcon: Icon(OMIcons.assignment),
                  labelText: "Enter weight in lbs",
                  errorStyle: TextStyle(
                      color: Theme.of(ctxt).errorColor,
                      fontWeight: FontWeight.bold),
                ),
                // Unless iOS show number keyboard
                keyboardType:
                    _isIOS ? TextInputType.text : TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: Helper.validateIfNumber,
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, submit data to database
                    _formKey.currentState.save();
                    SaveStateHelper.setBarWeight(_barWeight);
                    _formKey.currentState.reset();
                    Navigator.of(ctxt).pop();
                  }
                },
              )
            ],
          );
        },
      );
    }

    // devices context it needs to be rebuild along with the page
    void _showPlatesAvailableDialog(BuildContext ctxt) {
      // flutter defined function
      showDialog(
        context: ctxt,
        builder: (ctxt) {
          return AlertDialog(
            title: Text('Set plates available'),
            contentPadding: EdgeInsets.zero,
            content: PlateSelectionChips(dialogWindowContext: ctxt),
          );
        },
      );
    }

    return Drawer(
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
            // To make the top portion of the side drawer a different color
            // decoration: BoxDecoration(
            //   color: Colors.red[200],
            // ),
          ),
          ListTile(
            leading: Icon(OMIcons.create, color: Colors.red[400]),
            title: Text('Set bar weight'),
            subtitle: Text('$_barWeight lbs'),
            onTap: () {
              Navigator.pop(ctxt); // Close the drawer first
              _showBarWeightDialog(ctxt);
            },
          ),
          ListTile(
            leading: Icon(OMIcons.hdrStrong, color: Colors.red[400]),
            title: Text('Set plates available'),
            onTap: () {
              Navigator.pop(ctxt); // Close the drawer first
              _showPlatesAvailableDialog(ctxt);
            },
          ),
          ListTile(
            leading: Icon(OMIcons.assignment, color: Colors.red[400]),
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
            leading: Icon(OMIcons.timelapse, color: Colors.red[400]),
            title: Text('Start a new streak'),
            onTap: () {
              Navigator.pop(ctxt); // Close the drawer first
              _showResetDialog(ctxt); // Show the reset dialog
            },
          ),
          ListTile(
            leading: Icon(OMIcons.brightness2, color: Colors.red[400]),
            title: Text('Dark Mode'),
            trailing: Switch(
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
            leading: Icon(OMIcons.info, color: Colors.red[400]),
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

class SideDrawer extends StatefulWidget {
  SideDrawer({
    Key key,
    this.callBackWeeksPage,
  }) : super(key: key);

  final Function callBackWeeksPage;

  @override
  _SideDrawerState createState() => _SideDrawerState();
}
