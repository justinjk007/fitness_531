import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// TODO: activate links
class AboutPage extends StatelessWidget {
  // _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   }
  // }

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
              SizedBox(height: 30),
              FlatButton.icon(
                // onPressed: _launchURL("mailto:justinjoseph0007@gmail.com"),
                icon: Icon(EvaIcons.emailOutline),
                label: Text("Email me"),
              ),
              FlatButton.icon(
                // onPressed: _launchURL("https://twitter.com/justinjk007"),
                icon: Icon(EvaIcons.twitterOutline),
                label: Text("Twitter"),
              ),
              FlatButton.icon(
                // onPressed: _launchURL("https://github.com/justinjk007"),
                icon: Icon(EvaIcons.githubOutline),
                label: Text("Github"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
