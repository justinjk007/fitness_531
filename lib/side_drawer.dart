import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'new_records.dart';
import 'about_page.dart';
import 'save_state.dart';

class _SideDrawerState extends State<SideDrawer> {
  double _barWeight = 45;
  final _formKey = GlobalKey<FormState>();

  void _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
        // If no data exist return 45 meaning 45 lbs
        _barWeight = (prefs.getDouble("bar_weight") ?? 45);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // Load the current bar weight from memory
  }

  @override
  Widget build(BuildContext ctxt) {

    final bool _isIOS = Theme.of(ctxt).platform == TargetPlatform.iOS;

    // user defined function
    void _showResetDialog() {
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

    void addData(BuildContext ctxt) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble("bar_weight",_barWeight);
    }

    // user defined function
    void _showBarWeightDialog() {
      // flutter defined function
      showDialog(
        context: ctxt,
        builder: (ctxt) {
          return AlertDialog(
            title: Text('Set bar weight'),
            content:Form(
              key: _formKey,
              child: TextFormField(
                onSaved: (input) => _barWeight = double.parse(input),
                decoration: InputDecoration(
                  labelText: "Enter weight in lbs",
                  errorStyle: TextStyle(color: Theme.of(ctxt).errorColor,fontWeight: FontWeight.bold),
                ),
                // Unless iOS show number keyboard
                keyboardType:
                _isIOS ? TextInputType.text : TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text'; // The errorStyle property above styles this line
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return 'Please enter a number'; // The errorStyle property above styles this line
                  }
                },
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, submit data to database
                    _formKey.currentState.save();
                    addData(ctxt);
                    _formKey.currentState.reset();
                    Navigator.of(ctxt).pop();
                  }
                },
              )
            ],
          );
      });
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
              _showBarWeightDialog();
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
              _showResetDialog(); // Show the reset dialog
            },
          ),
          // ListTile(
          //   leading: Icon(OMIcons.brightness2, color: Colors.red[400]),
          //   title: Text('Dark Mode'),
          //   trailing: Switch(
          //     // activeTrackColor: Colors.lightGreenAccent,
          //     // activeColor: Colors.green,
          //     value:
          //     Theme.of(ctxt).brightness == Brightness.dark ? true : false,
          //     onChanged: (value) {
          //       DynamicTheme.of(ctxt).setBrightness(
          //         Theme.of(ctxt).brightness == Brightness.dark
          //         ? Brightness.light
          //         : Brightness.dark);
          //     },
          //   ),
          // ),
          ListTile(
            leading: Icon(OMIcons.brightness2, color: Colors.red[400]),
            title: Text('Dark Mode'),
            trailing: DayNightSwitch(
              value:Theme.of(ctxt).brightness == Brightness.dark ? true : false,
              sunColor: Colors.red,
              moonColor: Colors.yellow,
              dayColor: Colors.white,
              nightColor: Colors.black,
              onChanged: (value) {
                DynamicTheme.of(ctxt).setBrightness(
                  Theme.of(ctxt).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark);
              },
            )
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
