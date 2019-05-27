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
              const Text(
                "5/3/1 Fitness was written so I could learn flutter reactive framework, "
                "stop crunching percentages and calculating plate counts at the gym for the 5/3/1 fitness regimen. "
                "Now daily workout routines are already calculated and tracked, I can just"
                " focus on my training.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
