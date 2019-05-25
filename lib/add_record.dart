import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date time

class _AddRecordsPageState extends State<AddRecordsPage> {
  final _formKey = GlobalKey<FormState>();
  int _squatRM = 0;
  int _benchRM = 0;
  int _deadliftRM = 0;
  int _pressRM = 0;

  @override
  Widget build(BuildContext ctxt) {
    Future<String> getUserID() async {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String uid = user.uid.toString();
      return uid;
    }

    String _getTodaysDate() {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyyMMdd');
      return formatter.format(now);
    }

    void addData(BuildContext ctxt) async {
      const _pass_msg = SnackBar(content: Text('Added data to database'));
      const _fail_msg = SnackBar(content: Text('Failed to add data!'));
      await Firestore.instance
          .collection("users/max_reps/${await getUserID()}")
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
                  labelText: 'Enter 1RM for squat',
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
                  labelText: 'Enter 1RM for bench',
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
                  labelText: 'Enter 1RM for deadlift',
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
                  labelText: 'Enter 1RM for press',
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
