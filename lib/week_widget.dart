import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'save_state.dart';
import 'activity_page.dart';

class _WeekWidgetState extends State<Weeks> {
  void notifyReceiver() {
    setState(() {
      // Empty method just to refresh widget, collecting new data is handled by
      // FutureBuilder. It gets data from memory and loads a default if it
      // doens't find any

      // This will refresh week widgets status
    });
  }

  Widget _getNextScreen() {
    Widget nextScreen = new ActivityPage(
        // notifyParent: notifyReceiver,
        weekIDForChild: widget.weekID);
    return nextScreen;
  }

  Widget _getProgressWidget(int percent) {
    if (percent == 100) {
      return Icon(OMIcons.checkCircle, color: Colors.red[300], size: 52.0);
    } else {
      return CircularPercentIndicator(
        radius: 45.0,
        lineWidth: 5.0,
        animation: true,
        animationDuration: 1000,
        percent: percent / 100,
        center: Text(
          "$percent%",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: Colors.red[300],
      );
    }
  }

  @override
  Widget build(BuildContext ctxt) {
    return Card(
      child: SizedBox(
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
                leading: FutureBuilder<int>(
                  future: SaveStateHelper.getWeek(widget.weekID),
                  initialData: 0,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.hasError) {
                      return _getProgressWidget(0);
                    } else {
                      return _getProgressWidget(snapshot.data);
                    }
                  }, // End of  builder
                ), // End of FutureBuilder
              )
            ], // End of list
          ),
        ),
      ),
    );
  }
}

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

  final _WeekWidgetState state = new _WeekWidgetState();

  @override
  _WeekWidgetState createState() => state;

  void update() {
    state.notifyReceiver(); // This method is in _WeekWidgetState class
  }
}
