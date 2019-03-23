import 'package:flutter/material.dart';

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

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Multi Page Application")),
      body: new Column(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
            child: new SizedBox(
              width: double.infinity,
              height: 144.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    ctxt,
                    new MaterialPageRoute(
                        builder: (ctxt) => new SecondScreen()),
                  );
                },
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(
                          Icons.looks_one,
                          color: Colors.blue,
                          size: 50.0,
                        ),
                        title: Text('Week 1'),
                        subtitle: Text('3 sets of 5 reps'),
                      ),
                    ], // End of list
                  ),
                ),
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
            child: new SizedBox(
              width: double.infinity,
              height: 144.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    ctxt,
                    new MaterialPageRoute(
                        builder: (ctxt) => new SecondScreen()),
                  );
                },
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(
                          Icons.looks_two,
                          color: Colors.blue,
                          size: 50.0,
                        ),
                        title: Text('Week 2'),
                        subtitle: Text('3 sets of 3 reps'),
                      ),
                    ], // End of list
                  ),
                ),
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
            child: new SizedBox(
              width: double.infinity,
              height: 144.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    ctxt,
                    new MaterialPageRoute(
                        builder: (ctxt) => new SecondScreen()),
                  );
                },
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(
                          Icons.looks_3,
                          color: Colors.blue,
                          size: 50.0,
                        ),
                        title: Text('Week 3'),
                        subtitle: Text('5/3/1 sets'),
                      ),
                    ], // End of list
                  ),
                ),
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
            child: new SizedBox(
              width: double.infinity,
              height: 144.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    ctxt,
                    new MaterialPageRoute(
                        builder: (ctxt) => new SecondScreen()),
                  );
                },
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(
                          Icons.looks_4,
                          color: Colors.blue,
                          size: 50.0,
                        ),
                        title: Text('Week 4'),
                        subtitle: Text('Deload week'),
                      ),
                    ], // End of list
                  ),
                ),
              ),
            ),
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
