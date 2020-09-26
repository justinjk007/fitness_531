import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date time
import 'query_helper.dart';
import 'auth.dart';
import 'helper.dart';

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
  // These are used when changing the keyboard focus
  final FocusNode _squatFocus = FocusNode();
  final FocusNode _benchFocus = FocusNode();
  final FocusNode _deadliftFocus = FocusNode();
  final FocusNode _pressFocus = FocusNode();

  void _loadMaxRep() async {
    if (widget.keyword == "current") {
      // One of the current record is being updated
      await Firestore.instance
          .collection("users/max_reps/${await AuthHelper.getUserID()}")
          .document(widget.documentID)
          .get()
          .then((DocumentSnapshot _maxRep) {
        // Gives you the specific document that the user is trying to edit, so display it
        setState(() {
          _currentSquatRM = _maxRep.data['squat'];
          _currentBenchRM = _maxRep.data['bench'];
          _currentDeadliftRM = _maxRep.data['deadlift'];
          _currentPressRM = _maxRep.data['press'];
        });
      });
    } else {
      // Most likely means keyword is latest meaning new record is added
      List<DocumentSnapshot> _maxRep =
          await QueryHelper.getMaxRepListFromDatabase();
      if (_maxRep != null) {
        setState(() {
          // _maxRep is a list with only 1 item, which is the sorted by date and
          // only gives you the latest record
          _currentSquatRM = _maxRep[0].data['squat'];
          _currentBenchRM = _maxRep[0].data['bench'];
          _currentDeadliftRM = _maxRep[0].data['deadlift'];
          _currentPressRM = _maxRep[0].data['press'];
        });
      }
    }
  }

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

  void updateData(BuildContext ctxt) async {
    const _pass_msg = SnackBar(content: Text('Updated data'));
    const _fail_msg = SnackBar(content: Text('Failed to update data!'));
    await Firestore.instance
        .collection("users/max_reps/${await AuthHelper.getUserID()}")
        .document(widget.documentID)
        .updateData({
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

  String _getTodaysDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyyMMdd');
    return formatter.format(now);
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    // currentFocus.unfocus();
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _unFocusNode(BuildContext context) {
    // FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _loadMaxRep(); // Load all the Max rep values from memory async
  }

  @override
  Widget build(BuildContext ctxt) {
    // Don't show fab if keyboard is up
    final bool _keyboardNotUp = MediaQuery.of(context).viewInsets.bottom == 0.0;
    final bool _isIOS = Theme.of(ctxt).platform == TargetPlatform.iOS;

    return Scaffold(
      appBar: new AppBar(title: new Text(widget.title)),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              TextFormField(
                keyboardType:
                    _isIOS ? TextInputType.text : TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: Helper.validateIfNumber,
                decoration: InputDecoration(
                  labelText:
                      'Enter 1RM for squat (${widget.keyword}: $_currentSquatRM)',
                  prefixIcon: Icon(OMIcons.assignment),
                  errorStyle: TextStyle(
                      color: Theme.of(ctxt).errorColor,
                      fontWeight: FontWeight.bold),
                ),
                focusNode: _squatFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(ctxt, _squatFocus, _benchFocus);
                },
                onSaved: (input) => _squatRM = int.parse(input),
              ),
              TextFormField(
                keyboardType:
                    _isIOS ? TextInputType.text : TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: Helper.validateIfNumber,
                decoration: InputDecoration(
                  labelText:
                      'Enter 1RM for bench (${widget.keyword}: $_currentBenchRM)',
                  prefixIcon: Icon(OMIcons.assignment),
                  errorStyle: TextStyle(
                      color: Theme.of(ctxt).errorColor,
                      fontWeight: FontWeight.bold),
                ),
                focusNode: _benchFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(ctxt, _benchFocus, _deadliftFocus);
                },
                onSaved: (input) => _benchRM = int.parse(input),
              ),
              TextFormField(
                keyboardType:
                    _isIOS ? TextInputType.text : TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: Helper.validateIfNumber,
                decoration: InputDecoration(
                  labelText:
                      'Enter 1RM for deadlift (${widget.keyword}: $_currentDeadliftRM)',
                  prefixIcon: Icon(OMIcons.assignment),
                  errorStyle: TextStyle(
                      color: Theme.of(ctxt).errorColor,
                      fontWeight: FontWeight.bold),
                ),
                focusNode: _deadliftFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(ctxt, _deadliftFocus, _pressFocus);
                },
                onSaved: (input) => _deadliftRM = int.parse(input),
              ),
              TextFormField(
                keyboardType:
                    _isIOS ? TextInputType.text : TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: Helper.validateIfNumber,
                decoration: InputDecoration(
                  labelText:
                      'Enter 1RM for press (${widget.keyword}: $_currentPressRM)',
                  prefixIcon: Icon(OMIcons.assignment),
                  errorStyle: TextStyle(
                      color: Theme.of(ctxt).errorColor,
                      fontWeight: FontWeight.bold),
                ),
                focusNode: _pressFocus,
                onFieldSubmitted: (term) {
                  _unFocusNode(ctxt); // close the keyboard
                },
                onSaved: (input) => _pressRM = int.parse(input),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext ctxt) {
        return _keyboardNotUp
            ? FloatingActionButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, submit data to database
                    _formKey.currentState.save();
                    if (widget.keyword == "current") {
                      // One of the current record is being updated
                      updateData(ctxt);
                    } else {
                      // Most likely means keyword is latest meaning new record is added
                      addData(ctxt);
                    }
                    _formKey.currentState.reset();
                  }
                },
                child: Icon(Icons.done),
                tooltip: "Submit values",
                backgroundColor: Colors.red[400],
              )
            : new Container(); // Show null if _keyboardNotUp is false
      }),
    );
  }
}

class AddRecordsPage extends StatefulWidget {
  AddRecordsPage({
    Key key,
    this.title,
    this.keyword,
    this.documentID,
  }) : super(key: key);

  final String title;
  // Keyword can be words like "latest" or "current" , if the user is adding a
  // new record, we can show the "latest" data as a hint, if the user is
  // updating an existing record we can show the "current" values after showing
  // the "current" data
  final String keyword;
  final String documentID; // If editing a record, document_id of the record

  @override
  _AddRecordsPageState createState() => _AddRecordsPageState();
}
