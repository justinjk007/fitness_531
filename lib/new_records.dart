import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rect_getter/rect_getter.dart'; //<--Import rect getter
import 'add_record.dart';
import 'auth.dart'; // To sign in with Google and check sign in status

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
  String userId = "null";
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;

  // https://marcinszalek.pl/flutter/ripple-animation/
  // For ripple from FAB
  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
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
      Future.delayed(animationDuration + delay, goToAddingRecordsPageForReal);
    });
  }

  void _getUserID() async {
    userId = await AuthHelper.getUserID();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUserID();
  }

  void goToAddingRecordsPageForReal() {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    Navigator.push(
      context,
      FadeRouteBuilder(page: AddRecordsPage()),
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

  Card buildItem(DocumentSnapshot doc) {
    String dateDataWasAdded = doc.data['date'].substring(0, 4) +
        "-" +
        doc.data['date'].substring(4, 6) +
        "-" +
        doc.data['date'].substring(6, 8);

    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              dateDataWasAdded,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                SizedBox(width: 7),
                Column(
                  // This is so lines start from the same position
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Squat: ${doc.data['squat']} lbs"),
                    SizedBox(height: 10),
                    Text("Bench: ${doc.data['bench']} lbs"),
                  ],
                ),
                Expanded(child: SizedBox()),
                Column(
                  // This is so lines start from the same position
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Deadlift: ${doc.data['deadlift']} lbs"),
                    SizedBox(height: 10),
                    Text("Press: ${doc.data['press']} lbs"),
                  ],
                ),
                SizedBox(width: 7),
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
    Widget fancyFAB = RectGetter(
      //<-- Wrap Fab with RectGetter
      key: rectGetterKey, //<-- Passing the key
      child: FloatingActionButton(
        onPressed: goToAddingRecordsPage,
        child: Icon(Icons.add),
        tooltip: "Add new record",
        backgroundColor: Colors.red[400],
      ),
    );

    Widget loadDataWidget = StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("users/max_reps/$userId") // subcollection
          .orderBy("date", descending: true) // new entries first
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Can't really center this because this is inside a list view so I add padding to the top
          return Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: <Widget>[
                Icon(
                  OMIcons.cloudOff,
                  size: 40,
                  color: Theme.of(context).hintColor,
                ),
                Text(
                  "Sync_problem!",
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ],
            ),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Padding(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          default:
            return Column(
                children: snapshot.data.documents
                    .map((doc) => buildItem(doc))
                    .toList());
        }
      },
    );

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
              FutureBuilder<bool>(
                future: AuthHelper.checkIfUserIsLoggedIn(),
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasError) {
                    // Can't really center this because this is inside a list view so I add padding to the top
                    return Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            OMIcons.cloudOff,
                            size: 40,
                            color: Theme.of(context).hintColor,
                          ),
                          Text(
                            "Sync problem!",
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                        ],
                      ),
                    );
                  } else {
                    if (snapshot.data == true) {
                      return loadDataWidget; // User is logged in, he should see records
                    } else {
                      // User is not logged in
                      // Can't really center this because this is inside a list view so I add padding to the top
                      return Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              OMIcons.accountCircle,
                              size: 40,
                              color: Theme.of(context).hintColor,
                            ),
                            Text(
                              "Please login!",
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                }, // End of  builder
              ),
            ],
          ),
          floatingActionButton: FutureBuilder<bool>(
            future: AuthHelper.checkIfUserIsLoggedIn(),
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasError) {
                return Container(); // Return empty container
              } else {
                if (snapshot.data == true) {
                  return fancyFAB; // User is logged in, he can add records
                } else {
                  // User is not logged in
                  return Container(); // Return empty container
                }
              }
            }, // End of  builder
          ), // End of FutureBuilder
        ),
        _ripple(), //<-- Add the ripple widget
      ],
    );
  }

  // void createData() async {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     DocumentReference ref = await db
  //         .collection('MaxReps')
  //         .add({'name': '$name 😎', 'todo': someTodo()});
  //     setState(() => id = ref.documentID);
  //     print(ref.documentID);
  //   }
  // }

  // void readData() async {
  //   DocumentSnapshot snapshot =
  //       await db.collection('MaxReps').document(id).get();
  // }

  // void updateData(DocumentSnapshot doc) async {
  //   await db
  //       .collection('MaxReps')
  //       .document(doc.documentID)
  //       .updateData({'todo': 'please 🤫'});
  // }

  // void deleteData(DocumentSnapshot doc) async {
  //   await db.collection('MaxReps').document(doc.documentID).delete();
  //   setState(() => id = null);
  // }

}
