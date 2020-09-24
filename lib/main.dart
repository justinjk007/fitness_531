import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For forcing device orientation
import 'week_page.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Need to do this after flutter upgrade
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  ThemeData _buildTheme(Brightness brightness) {
    // The themes are defined in dark_theme.dart and light_theme.dart
    return brightness == Brightness.dark ? darkTheme : lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) => _buildTheme(brightness),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          theme: theme,
          // darkTheme: darkTheme, // Used in Android > 9, if user turns on system wide dark mode
          color: Theme.of(context).primaryColor,
          home: new WeekPage(),
        );
      },
    );
  }
}
