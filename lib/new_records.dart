import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  // TODO: Make these cards shadow just like cards in sets and reps page
  // TODO: Add a FAB with which we can add a new record
  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // This is so lines start from the same position
              children: <Widget>[
                Text("Squat: ${doc.data['squat']} lbs"),
                SizedBox(height: 10),
                Text("Bench: ${doc.data['bench']} lbs"),
              ],
            ),
            Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // This is so lines start from the same position
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
    return Scaffold(
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
