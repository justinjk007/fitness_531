import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rect_getter/rect_getter.dart'; //<--Import rect getter
import 'records.dart';

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;
  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}

class FirestoreCRUDPage extends StatefulWidget {
  @override
  FirestoreCRUDPageState createState() {
    return FirestoreCRUDPageState();
  }
}

class FirestoreCRUDPageState extends State<FirestoreCRUDPage> {
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;

  // https://marcinszalek.pl/flutter/ripple-animation/
  // For ripple from FAB
  final Duration animationDuration = Duration(milliseconds: 200);
  final Duration delay = Duration(milliseconds: 400);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey(); //<--Create a key
  Rect rect; //<--Declare field of rect

  void goToAddingRecordsPage() async {
    //<-- set rect to be size of fab
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //<-- on the next frame...
      //<-- set rect to be big
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      //<-- after delay, go to next page
      Future.delayed(animationDuration+delay, goToAddingRecordsPageForReal);
    });
  }

  void goToAddingRecordsPageForReal() {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    Navigator.push(
      context,
      FadeRouteBuilder(page: RecordsPage()),
    ).then((_) => setState(() => rect = null));
  }

  // This widget appears on top of the page during the ripple transition
  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      //<--replace Positioned with AnimatedPositioned
      duration: animationDuration, //<--specify the animation duration
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red[300],
        ),
      ),
    );
  }

  // TODO: Make these cards shadow just like cards in sets and reps page
  // TODO: Make the input record page connect to the database
  // TODO: Correct the height and width of activity widget using media queries for padding and widget size(Do some math)
  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // This is so lines start from the same position
              children: <Widget>[
                Text("Squat: ${doc.data['squat']} lbs"),
                SizedBox(height: 10),
                Text("Bench: ${doc.data['bench']} lbs"),
              ],
            ),
            Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // This is so lines start from the same position
              children: <Widget>[
                Text("Deadlift: ${doc.data['deadlift']} lbs"),
                SizedBox(height: 10),
                Text("Press: ${doc.data['press']} lbs"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'name',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      onSaved: (value) => name = value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      //<-- Wrap Scaffold with a Stack
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text('Records'),
          ),
          body: ListView(
            padding: EdgeInsets.all(8),
            children: <Widget>[
              // Form(
              //   key: _formKey,
              //   child: buildTextFormField(),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: <Widget>[
              //     RaisedButton(
              //       onPressed: createData,
              //       child: Text('Create', style: TextStyle(color: Colors.white)),
              //       color: Colors.green,
              //     ),
              //     RaisedButton(
              //       onPressed: id != null ? readData : null,
              //       child: Text('Read', style: TextStyle(color: Colors.white)),
              //       color: Colors.blue,
              //     ),
              //   ],
              // ),
              StreamBuilder<QuerySnapshot>(
                stream: db.collection('MaxReps').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data.documents
                            .map((doc) => buildItem(doc))
                            .toList());
                  } else {
                    return SizedBox();
                  }
                },
              )
            ],
          ),
          floatingActionButton: RectGetter(
            //<-- Wrap Fab with RectGetter
            key: rectGetterKey, //<-- Passing the key
            child: FloatingActionButton(
              onPressed: goToAddingRecordsPage,
              child: Icon(Icons.add),
              tooltip: "Add new record",
              backgroundColor: Colors.red[400],
            ),
          ),
        ),
        _ripple(), //<-- Add the ripple widget
      ],
    );
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db
          .collection('MaxReps')
          .add({'name': '$name 😎', 'todo': someTodo()});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }

  void readData() async {
    DocumentSnapshot snapshot =
        await db.collection('MaxReps').document(id).get();
  }

  void updateData(DocumentSnapshot doc) async {
    await db
        .collection('MaxReps')
        .document(doc.documentID)
        .updateData({'todo': 'please 🤫'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('MaxReps').document(doc.documentID).delete();
    setState(() => id = null);
  }

  String someTodo() {
    final someNumber = 4;
    String todo;
    switch (someNumber) {
      case 1:
        todo = 'Like and subscribe 💩';
        break;
      case 2:
        todo = 'Twitter @robertbrunhage 🤣';
        break;
      case 3:
        todo = 'Patreon in the description 🤗';
        break;
      default:
        todo = 'Leave a comment 🤓';
        break;
    }
    return todo;
  }
}