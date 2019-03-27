import 'package:flutter/material.dart';
import 'save_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: new FirstScreen(),
    );
  }
}

class Weeks extends StatefulWidget {
  Weeks({
    Key key,
    this.argTitle,
    this.subTitle,
    this.cardIcon,
    this.weekNum,
  }) : super(key: key);

  final Widget argTitle;
  final Widget subTitle;
  final Icon cardIcon;
  final int weekNum;
  @override
  _WeekWidgetState createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<Weeks> {
  String _text = 'active'; // By default each week us active

  void notifyReceiver() {
    setState(() {
      // Empty method just to refresh widget, collecting new data is handled
      // by FutureBuilder
    });
  }

  Widget _getNextScreen() {
    Widget nextScreen = new SecondScreen();
    if (widget.weekNum == 3) {
      nextScreen = new ThirdScreen(notifyParent: notifyReceiver);
    }
    return nextScreen;
  }

  @override
  Widget build(BuildContext ctxt) {
    return (new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: new SizedBox(
        width: double.infinity,
        height: 144.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
              ctxt,
              new MaterialPageRoute(builder: (ctxt) => _getNextScreen()),
            );
          },
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: widget.cardIcon,
                    title: widget.argTitle,
                    subtitle: FutureBuilder<bool>(
                        future: SaveStateHelper.getWeek3(),
                        initialData: true,
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Text('Results: ${snapshot.data}');
                            // if (snapshot.data) {
                            //   return Text('active');
                            // } else {
                            //   return Text('inactive');
                            // }
                          }
                        } // End of  builder
                        ) // End of FutureBuilder
                    )
              ], // End of list
            ),
          ),
        ),
      ),
    ));
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Select week in your routine")),
      body: new Column(
        children: <Widget>[
          new Weeks(
            argTitle: new Text("Week 1"),
            // subTitle: new Text("3 sets of 5 reps"),
            subTitle: new Text("active"),
            cardIcon: new Icon(Icons.looks_one, color: Colors.red, size: 50.0),
          ),
          new Weeks(
            argTitle: new Text("Week 2"),
            // subTitle: new Text("3 sets of 3 reps"),
            subTitle: new Text("active"),
            cardIcon: new Icon(Icons.looks_two, color: Colors.red, size: 50.0),
          ),
          new Weeks(
            argTitle: new Text("Week 3"),
            // subTitle: new Text("5/3/1 sets"),
            subTitle: new Text("active"),
            cardIcon: new Icon(Icons.looks_3, color: Colors.red, size: 50.0),
            weekNum: 3,
          ),
          new Weeks(
            argTitle: new Text("Week 4"),
            // subTitle: new Text("Deload week"),
            subTitle: new Text("active"),
            cardIcon: new Icon(Icons.looks_4, color: Colors.red, size: 50.0),
          ),
        ], // List of cards end here
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Multi Page Application Page 2"),
      ),
      body: new Text("Another Page...!!!!!!"),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  final Function() notifyParent;
  ThirdScreen({Key key, @required this.notifyParent}) : super(key: key);

  void saveData() async {
    await SaveStateHelper.setWeek3(false);
    notifyParent();
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Multi Page Application Page 3"),
      ),
      body: new RaisedButton(
        padding: const EdgeInsets.all(8.0),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          saveData();
        },
        child: new Text("Click to notify parent!"),
      ),
    );
  }
}
