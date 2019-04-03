import 'package:flutter/material.dart';

class RecordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      // drawer: new SideDrawer(),
      appBar: new AppBar(title: new Text("Set 1 rep max records")),
      body: Padding(
        padding: EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Enter 1RM for squat'),
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(hintText: 'Enter 1RM for bench'),
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(hintText: 'Enter 1RM for deadlift'),
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(hintText: 'Enter 1RM for press'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
