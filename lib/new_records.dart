import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:rect_getter/rect_getter.dart'; //<--Import rect getter
import 'package:intl/intl.dart'; // For date time
import 'setsandreps_widget.dart';
import 'record_time_series.dart';
import 'add_record.dart';
import 'help_info.dart';
import 'charts.dart';
import 'auth.dart'; // To sign in with Google and check sign in status

///////////////////////////////////////////////////////////////////////////////////////////////////
// This page's' widget tree is called new_records becuase this app used to have an old page were //
// offline records can be saved to file called records.                                          //
///////////////////////////////////////////////////////////////////////////////////////////////////

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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  String userId = "null";

  // https://marcinszalek.pl/flutter/ripple-animation/
  // For ripple from FAB
  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey(); //<--Create a key
  Rect rect; //<--Declare field of rect

  @override
  void initState() {
    super.initState();
    _getUserID();
  }

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

  void goToAddingRecordsPageForReal() {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    Navigator.push(
      context,
      FadeRouteBuilder(
          page: AddRecordsPage(
        title: "Add new 1 RM records!",
        keyword: "latest",
      )),
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

  // user defined function
  void _showEditorDeleteDialog(String docId, BuildContext ctxt) {
    // flutter defined function
    const _fail_msg = SnackBar(content: Text('Failed to delete data!'));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Edit record"),
          // content: Text("This will remove the record forever"),
          actions: <Widget>[
            // Usually buttons at the bottom of the dialog
            FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(OMIcons.deleteForever),
                  SizedBox(width: 2.5), // Padding on each side to look better
                  Text("Delete"),
                ],
              ),
              onPressed: () async {
                await Firestore.instance
                    .collection(
                        "users/max_reps/${await AuthHelper.getUserID()}")
                    .document(docId)
                    .delete()
                    .then((_) {
                  // Don't really need to do anything
                }).catchError((_) {
                  Scaffold.of(ctxt).showSnackBar(_fail_msg);
                });
                // Exit out of the window after reseting
                Navigator.of(ctxt).pop();
              },
            ),
            FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(OMIcons.edit),
                  SizedBox(width: 2.5), // Padding on each side to look better
                  Text("Edit"),
                ],
              ),
              onPressed: () async {
                // Exit out of the window after reseting
                Navigator.of(ctxt).pop();
                Navigator.push(
                  ctxt,
                  new MaterialPageRoute(
                    builder: (ctxt) => AddRecordsPage(
                      title: "Edit the record!",
                      keyword: "current",
                      documentID: docId,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
                width: 10), // Add a little bit of padding after the last button
          ], // Actions ends here
        );
      },
    );
  }

  void _showRecordDetails(
    int squatMax,
    int benchMax,
    int deadliftMax,
    int pressMax,
    BuildContext ctxt,
  ) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(
          children: <Widget>[
            CustomCard(
              argTitle: "$squatMax",
              subTitle: "Squat",
              setWeight: squatMax.toDouble(),
            ),
            CustomCard(
              argTitle: "$benchMax",
              subTitle: "Bench",
              setWeight: benchMax.toDouble(),
            ),
            CustomCard(
              argTitle: "$deadliftMax",
              subTitle: "Deadlift",
              setWeight: deadliftMax.toDouble(),
            ),
            CustomCard(
              argTitle: "$pressMax",
              subTitle: "Press",
              setWeight: pressMax.toDouble(),
            )
          ],
        );
      },
    );
  }

  Widget buildCard(DataBaseRecords record, BuildContext ctxt, Animation anim) {
    // Here each record passed id one of the elements in the list, so parse
    // that, build a card and return it

    DateFormat formatter =
        new DateFormat.yMMMMd("en_US"); // styled like July 10, 1996
    String dateDataWasAdded = formatter.format(record.date); // July 10, 1996

    return FadeTransition(
      opacity: anim,
      child: Card(
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
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
                            Text("Squat: ${record.squatMax} lbs"),
                            SizedBox(height: 10),
                            Text("Bench: ${record.benchMax} lbs"),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Column(
                          // This is so lines start from the same position
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Deadlift: ${record.deadliftMax} lbs"),
                            SizedBox(height: 10),
                            Text("Press: ${record.pressMax} lbs"),
                          ],
                        ),
                        SizedBox(width: 7),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Inkwell should be placed on the botton to ripple all over
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onLongPress: () {
                    _showEditorDeleteDialog(record.docID, ctxt);
                  },
                  onTap: () {
                    _showRecordDetails(
                      record.squatMax,
                      record.benchMax,
                      record.deadliftMax,
                      record.pressMax,
                      ctxt,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This widget is based on the screen context so needs to be rebuild
    // everytime the screen is rebuild so no point of separating this outside
    // and supplying the context
    Widget fancyFAB = RectGetter(
      // Wrap Fab with RectGetter
      key: this.rectGetterKey, //<-- Passing the key
      child: FloatingActionButton(
        onPressed: goToAddingRecordsPage,
        child: Icon(Icons.add),
        tooltip: "Add new record",
        backgroundColor: Colors.red[400],
      ),
    );

    // This widget is based on the screen context so needs to be rebuild
    // everytime the screen is rebuild so no point of separating this outside
    // and supplying the context
    Widget loadDataWidget = StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("users/max_reps/$userId") // subcollection
          .orderBy("date", descending: true) // new entries first
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return HelpInfo.syncProblemWidget(context);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return HelpInfo.centerCircularProgressIndicator();
          default:
            {
              List<DataBaseRecords> _records = snapshot.data.documents
                  .map((doc) => DataBaseRecords.fromMap(
                        doc.data,
                        doc.documentID,
                      ))
                  .toList();

              // Here I am messing with the list view add the graph as the first
              // item in the list. Hence length is +1 and index used is
              // -1. First item on the list is the Time Series chart. Since
              // itemBuilder builds item as things as scrolled. Scrolling to the
              // bottom and back up will have to reload the chart again, which
              // might cause perfomance issues in the future?
              return AnimatedList(
                padding: EdgeInsets.all(8),
                key: _listKey,
                initialItemCount: _records.length + 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index, Animation anim) {
                  if (index == 0) {
                    return SimpleTimeSeriesChart(_records);
                  } else {
                    return buildCard(_records[index - 1], context, anim);
                  }
                },
              );
            }
        }
      },
    );

    return Stack(
      //<-- Wrap Scaffold with a Stack
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text('Records'),
            // backgroundColor: Colors.transparent, //No more
            // elevation: 0.0, //Shadow gone
          ),
          body: FutureBuilder<bool>(
            future: AuthHelper.checkIfUserIsLoggedIn(),
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasError) {
                return HelpInfo.syncProblemWidget(context);
              } else {
                if (snapshot.data == true) {
                  // return HelpInfo.centerCircularProgressIndicator();
                  return loadDataWidget; // User is logged in, he should see records
                } else {
                  return HelpInfo.pleaseLoginWidget(context);
                }
              }
            }, // End of  builder
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
        _ripple(), // Add the ripple widget to the Stack which has the Scaffold,
        // for the ripple effect when clicking on the FAB
      ],
    );
  }
}
