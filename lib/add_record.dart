import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class _AddRecordsPageState extends State<AddRecordsPage> {
  final _formKey = GlobalKey<FormState>();
  int _squatRM = 0;
  int _benchRM = 0;
  int _deadliftRM = 0;
  int _pressRM = 0;

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Add new 1 RM records!")),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                final n = num.tryParse(value);
                if (n == null) {
                  return 'Numbers should be greater than 0';
                }
              },
              decoration: InputDecoration(
                labelText: 'Enter 1RM for squat',
                prefixIcon: Icon(Icons.assignment),
              ),
              onSaved: (input) => _squatRM = int.parse(input),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, we want to show a Snackbar
                    Scaffold.of(ctxt).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
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
