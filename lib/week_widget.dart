import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'save_state.dart';
import 'activity_page.dart';

class _WeekWidgetState extends State<Weeks> {

  int _week1Status = 0;
  int _week2Status = 0;
  int _week3Status = 0;
  int _week4Status = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadMaxRep(); // Load all the Max rep values from memory async
  // }

  // void _loadMaxRep() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     // If no data exist return 0
  //     _maxRep = (prefs.getInt(widget.activity) ?? 0);
  //     _assistanceMaxRep =
  //         (prefs.getInt(getAssistanceActivity(widget.activity)) ?? 0);
  //   });
  // }

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

  Widget _getProgressWidget(double percent) {
    Widget progress = new CircularPercentIndicator(
      radius: 45.0,
      lineWidth: 7.0,
      animation: true,
      animationDuration: 1000,
      percent: percent/100,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.red[300],
    );
    return progress;
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
                        // return Icon(Icons.check_box_outline_blank,
                        //     color: Colors.red[300], size: 50.0);
                        return _getProgressWidget(0.0);
                      } else {
                        if (snapshot.data == true) {
                          // Item is marked undone
                          // return Icon(Icons.check_box_outline_blank,
                          //     color: Colors.red[300], size: 50.0);
                          return _getProgressWidget(50);
                        } else {
                          // Item is marked done
                          return Icon(Icons.check_circle,
                              color: Colors.red[300], size: 52.0);
                        }
                      }
                    }, // End of  builder
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
