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
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(Colors.red.shade200.value, {
          50: Colors.red.shade50,
          100: Colors.red.shade100,
          200: Colors.red.shade200,
          300: Colors.red.shade300,
          400: Colors.red.shade400,
          500: Colors.red.shade500,
          600: Colors.red.shade600,
          700: Colors.red.shade700,
          800: Colors.red.shade800,
          900: Colors.red.shade900
        }),
      ),
      home: new FirstScreen(),
    );
  }
}
