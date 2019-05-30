import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'query_helper.dart';
import 'auth.dart';
import 'package:intl/intl.dart'; // For date time

class _AddRecordsPageState extends State<AddRecordsPage> {
  final _formKey = GlobalKey<FormState>();
  int _squatRM = 0; // Used when adding data to database
  int _benchRM = 0; // Used when adding data to database
  int _deadliftRM = 0; // Used when adding data to database
  int _pressRM = 0; // Used when adding data to database
  int _currentSquatRM = 0;
  int _currentBenchRM = 0;
  int _currentDeadliftRM = 0;
  int _currentPressRM = 0;

  void _loadMaxRep() async {
    List<DocumentSnapshot> _maxRep =
        await QueryHelper.getMaxRepListFromDatabase();
    if (_maxRep != null) {
      setState(() {
        // _maxRep is a list with only 1 item
        _currentSquatRM = _maxRep[0].data['squat'];
        _currentBenchRM = _maxRep[0].data['bench'];
        _currentDeadliftRM = _maxRep[0].data['deadlift'];
        _currentPressRM = _maxRep[0].data['press'];
      });
    }
  }

  String _getTodaysDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyyMMdd');
    return formatter.format(now);
  }

  @override
  void initState() {
    super.initState();
    _loadMaxRep(); // Load all the Max rep values from memory async
  }

  @override
  Widget build(BuildContext ctxt) {
    void addData(BuildContext ctxt) async {
      const _pass_msg = SnackBar(content: Text('Added data to database'));
      const _fail_msg = SnackBar(content: Text('Failed to add data!'));
      await Firestore.instance
          .collection("users/max_reps/${await AuthHelper.getUserID()}")
          .add({
        'squat': _squatRM,
        'bench': _benchRM,
        'deadlift': _deadliftRM,
        'press': _pressRM,
        'date': _getTodaysDate(),
      }).then((_) {
        Scaffold.of(ctxt).showSnackBar(_pass_msg);
      }).catchError((_) {
        Scaffold.of(ctxt).showSnackBar(_fail_msg);
      });
    }

    // Don't show fab if keyboard is up
    final bool showFab = MediaQuery.of(ctxt).viewInsets.bottom == 0.0;

    return Scaffold(
      appBar: new AppBar(title: new Text("Add new 1 RM records!")),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return 'Please enter a number';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter 1RM for squat (latest: $_currentSquatRM)',
                  prefixIcon: Icon(OMIcons.assignment),
                ),
                onSaved: (input) => _squatRM = int.parse(input),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return 'Please enter a number';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter 1RM for bench (latest: $_currentBenchRM)',
                  prefixIcon: Icon(OMIcons.assignment),
                ),
                onSaved: (input) => _benchRM = int.parse(input),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return 'Please enter a number';
                  }
                },
                decoration: InputDecoration(
                  labelText:
                      'Enter 1RM for deadlift (latest: $_currentDeadliftRM)',
                  prefixIcon: Icon(OMIcons.assignment),
                ),
                onSaved: (input) => _deadliftRM = int.parse(input),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return 'Please enter a number';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter 1RM for press (latest: $_currentPressRM)',
                  prefixIcon: Icon(OMIcons.assignment),
                ),
                onSaved: (input) => _pressRM = int.parse(input),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext ctxt) {
        return showFab
            ? FloatingActionButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, submit data to database
                    _formKey.currentState.save();
                    addData(ctxt);
                    _formKey.currentState.reset();
                  }
                },
                child: Icon(Icons.done),
                tooltip: "Submit values",
                backgroundColor: Colors.red[400],
              )
            : new Container(); // Show null if showFab is false
      }),
    );
  }
}

class AddRecordsPage extends StatefulWidget {
  AddRecordsPage({
    Key key,
  }) : super(key: key);

  @override
  _AddRecordsPageState createState() => _AddRecordsPageState();
}
