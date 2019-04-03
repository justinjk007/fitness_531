import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      // drawer: new SideDrawer(),
      appBar: new AppBar(title: new Text("About")),
      body: Padding(
        padding: EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                "5/3/1 Fitness was written so I could learn flutter reactive framework, "
                "stop crunching percentages and calculating plate counts at the gym. "
                "Now daily workout routines are already calculated and tracked, I can just"
                " focus on my training.\n\n PS: This page is written just for test.",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
