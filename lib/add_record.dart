import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class _AddRecordsPageState extends State<AddRecordsPage> {
  final _formKey = GlobalKey<FormState>();
  int _squatRM = 0;
  int _benchRM = 0;
  int _deadliftRM = 0;
  int _pressRM = 0;
  String _date = "20180908";

  @override
  Widget build(BuildContext ctxt) {
    void addData() async {
      await Firestore.instance.collection('MaxReps').add({
        'squat': _squatRM,
        'bench': _benchRM,
        'deadlift': _deadliftRM,
        'press': _pressRM,
        'date': _date,
      });
    }

    // TODO: Make the date variable actual date

    // TODO: Adding a record, adds records to MaxReps collection shared by
    // everyone, sign ip process should give each user his own collection

    // TODO: Give snackbar feedback after adding data

    return Scaffold(
      appBar: new AppBar(title: new Text("Add new 1 RM records!")),
      body: Padding(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
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
                  prefixIcon: Icon(Icons.assignment),
                ),
                onSaved: (input) => _squatRM = int.parse(input),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
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
                  prefixIcon: Icon(Icons.assignment),
                ),
                onSaved: (input) => _benchRM = int.parse(input),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
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
                  prefixIcon: Icon(Icons.assignment),
                ),
                onSaved: (input) => _deadliftRM = int.parse(input),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
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
                  prefixIcon: Icon(Icons.assignment),
                ),
                onSaved: (input) => _pressRM = int.parse(input),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, submit data to database
                      _formKey.currentState.save();
                      addData();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
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
