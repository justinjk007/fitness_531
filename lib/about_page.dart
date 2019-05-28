import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  _launchTwitter() async {
    String url = "https://twitter.com/justinjk007";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _launchMail() async {
    String url = "mailto:justinjoseph0007@gmail.com";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _launchGithub() async {
    String url = "https://github.com/justinjk007";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _launchDonate() async {
    String url = "https://www.paypal.me/justinjk007?locale.x=en_US";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: _launchMail,
                    icon: Icon(EvaIcons.emailOutline),
                    label: Text("Email me"),
                    splashColor: Colors.grey,
                  ),
                  FlatButton.icon(
                    onPressed: _launchTwitter,
                    icon: Icon(EvaIcons.twitterOutline),
                    label: Text("Twitter"),
                    splashColor: Colors.blue,
                  ),
                  FlatButton.icon(
                    onPressed: _launchGithub,
                    icon: Icon(EvaIcons.githubOutline),
                    label: Text("Github"),
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 30),
              FlatButton(
                onPressed: _launchDonate,
                child: Text("But me coffee ?"),
                splashColor: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
