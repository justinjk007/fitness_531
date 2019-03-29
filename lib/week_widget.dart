import 'package:flutter/material.dart';
import 'save_state.dart';
import 'activity_page.dart';

class Weeks extends StatefulWidget {
  Weeks({
    Key key,
    this.argTitle,
    this.subTitle,
    this.weekID,
  }) : super(key: key);

  final Widget argTitle;
  final Widget subTitle;
  final String weekID;
  @override
  _WeekWidgetState createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<Weeks> {
  void notifyReceiver() {
    setState(() {
      // Empty method just to refresh widget, collecting new data is handled by
      // FutureBuilder. It gets data from memory and loads a default if it
      // doens't find any
    });
  }

  Widget _getNextScreen() {
    Widget nextScreen = new ActivityPage(
        notifyParent: notifyReceiver, weekIDForChild: widget.weekID);
    return nextScreen;
  }

  @override
  Widget build(BuildContext ctxt) {
    return (new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: Card(
        child: new SizedBox(
          width: double.infinity,
          height: 130.0,
          child: InkWell(
            onTap: () {
              Navigator.push(
                ctxt,
                new MaterialPageRoute(builder: (ctxt) => _getNextScreen()),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: widget.argTitle,
                  subtitle: widget.subTitle,
                  leading: FutureBuilder<bool>(
                      future: SaveStateHelper.getWeek(widget.weekID),
                      initialData: true,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.hasError) {
                          return Icon(Icons.check_box_outline_blank,
                              color: Colors.red[300], size: 50.0);
                        } else {
                          if (snapshot.data == true) {
                            // Still active
                            return Icon(Icons.check_box_outline_blank,
                                color: Colors.red[300], size: 50.0);
                          } else {
                            // Inactive
                            return Icon(Icons.check_box,
                                color: Colors.red[300], size: 50.0);
                          }
                        }
                      } // End of  builder
                      ), // End of FutureBuilder
                )
              ], // End of list
            ),
          ),
        ),
      ),
    ));
  }
}
