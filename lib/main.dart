import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For forcing device orientation
import 'week_page.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  ThemeData _buildTheme(Brightness brightness) {
    return brightness == Brightness.dark
        ? ThemeData.dark().copyWith(
            textTheme: ThemeData.dark().textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
            primaryColor: Colors.red.shade300,
            accentColor: Colors.red.shade200,
            toggleableActiveColor: Colors.red.shade200,
            buttonColor: Colors.red.shade200,
          )
        : ThemeData.light().copyWith(
            textTheme: ThemeData.light().textTheme.apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                ),
            primaryColor: Colors.red.shade300,
            accentColor: Colors.red.shade200,
            toggleableActiveColor: Colors.red.shade200,
            buttonColor: Colors.red.shade200,
          );
  }

  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => _buildTheme(brightness),
      // data: (brightness) => new ThemeData(
      //       brightness: brightness,
      //       primarySwatch: MaterialColor(Colors.red.shade200.value, {
      //         50: Colors.red.shade50,
      //         100: Colors.red.shade100,
      //         200: Colors.red.shade200,
      //         300: Colors.red.shade300,
      //         400: Colors.red.shade400,
      //         500: Colors.red.shade500,
      //         600: Colors.red.shade600,
      //         700: Colors.red.shade700,
      //         800: Colors.red.shade800,
      //         900: Colors.red.shade900
      //       }),
      //     ),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          theme: theme,
          home: new WeekPage(),
        );
      },
    );
  }
}
