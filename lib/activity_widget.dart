import 'package:flutter/material.dart';
import 'setsandreps_page.dart';
import 'save_state.dart';

//////////////////////////////////////////////////////////////////////////////////////
// This is the widget that displays a picture of an exercise and is clickable which //
// take you to the next page.                                                       //
// This widget also have a done state.                                              //
//////////////////////////////////////////////////////////////////////////////////////

class Activity extends StatefulWidget {
  Activity({
    Key key,
    this.image,
    this.color,
    this.activity,
    this.weekID,
  }) : super(key: key);

  final String image;
  final Color color;
  final String activity;
  final String weekID;
  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<Activity> {
  void notifyReceiver() {
    setState(() {
      // Empty method just to refresh widget, collecting new data is handled by
      // FutureBuilder. It gets data from memory and loads a default if it
      // doens't find any
    });
  }

  Widget getNextScreen() {
    Widget nextScreen = new SetsAndRepsPage(
      activity: widget.activity,
      weekID: widget.weekID,
      notifyParent: notifyReceiver,
    );
    return nextScreen;
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Expanded(
      child: SizedBox(
        height: 250,
        child: Material(
          color: widget.color,
          elevation: 4.0,
          child: Stack(
            children: [
              Center(
                child: FutureBuilder<bool>(
                  future: SaveStateHelper.getActivity(
                    widget.weekID,
                    widget.activity,
                  ), // This is where Future is trying to get data from
                  initialData: false,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasError) {
                      return Icon(Icons.beenhere,
                          color: Colors.red[300].withOpacity(0.3), size: 0);
                    } else {
                      if (snapshot.data == true) {
                        // Item is marked undone
                        return Icon(Icons.beenhere,
                            color: Colors.red[300].withOpacity(0.3), size: 0);
                      } else {
                        // Item is marked done
                        return Icon(Icons.beenhere,
                            color: Colors.red[300].withOpacity(0.3), size: 150);
                      }
                    }
                  }, // End of  builder
                ), // End of FutureBuilder
              ),
              Positioned.fill(
                child: Ink.image(
                  image: AssetImage(widget.image),
                  width: 120.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => getNextScreen()),
                      );
                    },
                    splashColor: Colors.red[200],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
