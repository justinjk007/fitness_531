import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: MaterialColor(4292770682, {
    50: Color(0xfffaebeb),
    100: Color(0xfff5d6d6),
    200: Color(0xffebaead),
    300: Color(0xffe18584),
    400: Color(0xffd65d5c),
    500: Color(0xffcc3433),
    600: Color(0xffa32a29),
    700: Color(0xff7b1f1e),
    800: Color(0xff521514),
    900: Color(0xff290a0a)
  }),
  brightness: Brightness.light,
  primaryColor: Color(0xffde7b7a),
  primaryColorBrightness: Brightness.light,
  primaryColorLight: Color(0xfff5d6d6),
  primaryColorDark: Color(0xffd05655),
  accentColor: Color(0xffd15453),
  accentColorBrightness: Brightness.light,
  canvasColor: Color(0xffffffff),
  scaffoldBackgroundColor: Color(0xffffffff),
  bottomAppBarColor: Color(0xffffffff),
  cardColor: Color(0xffffffff),
  dividerColor: Color(0x1f000000),
  highlightColor: Color(0x66bcbcbc),
  splashColor: Color(0x66c8c8c8),
  selectedRowColor: Color(0xfff5f5f5),
  unselectedWidgetColor: Color(0x8a000000),
  disabledColor: Color(0x61000000),
  buttonColor: Color(0xfff38888),
  toggleableActiveColor: Color(0xffdd807f),
  secondaryHeaderColor: Color(0xfffaebeb),
  textSelectionColor: Color(0xffebaead),
  cursorColor: Color(0xffe87e7e),
  textSelectionHandleColor: Color(0xffe18584),
  backgroundColor: Color(0xffebaead),
  dialogBackgroundColor: Color(0xffffffff),
  indicatorColor: Color(0xffcc3433),
  hintColor: Color(0x8a000000),
  errorColor: Color(0xffd32f2f),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 0,
    color: Colors.transparent,
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      opacity: 1.0,
      size: 24.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      opacity: 1.0,
      size: 24.0,
    ),
    textTheme: TextTheme(
      display4: TextStyle(
        color: Color(0x8a000000),
        fontSize: 96.0,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
      ),
      display3: TextStyle(
        color: Color(0x8a000000),
        fontSize: 60.0,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
      ),
      display2: TextStyle(
        color: Color(0x8a000000),
        fontSize: 48.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      display1: TextStyle(
        color: Color(0x8a000000),
        fontSize: 34.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headline: TextStyle(
        color: Color(0xdd000000),
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      title: TextStyle(
        color: Color(0xdd000000),
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      subhead: TextStyle(
        color: Color(0xdd000000),
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      body2: TextStyle(
        color: Color(0xdd000000),
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      body1: TextStyle(
        color: Color(0xdd000000),
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      caption: TextStyle(
        color: Color(0x8a000000),
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      button: TextStyle(
        color: Color(0xdd000000),
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      subtitle: TextStyle(
        color: Color(0xff000000),
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      overline: TextStyle(
        color: Color(0xff000000),
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    minWidth: 88.0,
    height: 36.0,
    padding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0.0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(2.0),
      ),
    ),
    alignedDropdown: false,
    buttonColor: Color(0xfff38888),
    disabledColor: Color(0x61000000),
    highlightColor: Color(0x29000000),
    splashColor: Color(0xffffa3a3),
    colorScheme: ColorScheme(
      primary: Color(0xffde7b7a),
      primaryVariant: Color(0xff7b1f1e),
      secondary: Color(0xffcc3433),
      secondaryVariant: Color(0xff7b1f1e),
      surface: Color(0xffffffff),
      background: Color(0xffebaead),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xffffffff),
      onSurface: Color(0xff000000),
      onBackground: Color(0xffffffff),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
  ),
  textTheme: TextTheme(
    display4: TextStyle(
      color: Color(0x8a000000),
      fontSize: 96.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    ),
    display3: TextStyle(
      color: Color(0x8a000000),
      fontSize: 60.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    ),
    display2: TextStyle(
      color: Color(0x8a000000),
      fontSize: 48.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    display1: TextStyle(
      color: Color(0x8a000000),
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline: TextStyle(
      color: Color(0xdd000000),
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    title: TextStyle(
      color: Color(0xdd000000),
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    subhead: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    body2: TextStyle(
      color: Color(0xdd000000),
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    body1: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    caption: TextStyle(
      color: Color(0x8a000000),
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    button: TextStyle(
      color: Color(0xdd000000),
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    subtitle: TextStyle(
      color: Color(0xff000000),
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    overline: TextStyle(
      color: Color(0xff000000),
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  primaryTextTheme: TextTheme(
    display4: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 96.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    ),
    display3: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 60.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    ),
    display2: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 48.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    display1: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline: TextStyle(
      color: Color(0xffffffff),
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    title: TextStyle(
      color: Color(0xffffffff),
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    subhead: TextStyle(
      color: Color(0xffffffff),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    body2: TextStyle(
      color: Color(0xffffffff),
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    body1: TextStyle(
      color: Color(0xffffffff),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    caption: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    button: TextStyle(
      color: Color(0xffffffff),
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    subtitle: TextStyle(
      color: Color(0xffffffff),
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    overline: TextStyle(
      color: Color(0xffffffff),
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  accentTextTheme: TextTheme(
    display4: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 96.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    ),
    display3: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 60.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    ),
    display2: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 48.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    display1: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline: TextStyle(
      color: Color(0xffffffff),
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    title: TextStyle(
      color: Color(0xffffffff),
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    subhead: TextStyle(
      color: Color(0xffffffff),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    body2: TextStyle(
      color: Color(0xffffffff),
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    body1: TextStyle(
      color: Color(0xffffffff),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    caption: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    button: TextStyle(
      color: Color(0xffffffff),
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    subtitle: TextStyle(
      color: Color(0xffffffff),
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    overline: TextStyle(
      color: Color(0xffffffff),
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    hasFloatingPlaceholder: true,
    isDense: false,
    contentPadding:
        EdgeInsets.only(top: 12.0, bottom: 12.0, left: 0.0, right: 0.0),
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: false,
    fillColor: Color(0x00000000),
    errorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
  iconTheme: IconThemeData(
    color: Color(0xdd000000),
    opacity: 1.0,
    size: 24.0,
  ),
  primaryIconTheme: IconThemeData(
    color: Color(0xffffffff),
    opacity: 1.0,
    size: 24.0,
  ),
  accentIconTheme: IconThemeData(
    color: Color(0xffffffff),
    opacity: 1.0,
    size: 24.0,
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xff000000),
    unselectedLabelColor: Color(0xb2000000),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Color(0x1f000000),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde000000),
    disabledColor: Color(0x0c000000),
    labelPadding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 8.0, right: 8.0),
    labelStyle: TextStyle(
      color: Color(0xde000000),
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 4.0, right: 4.0),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d000000),
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    secondarySelectedColor: Color(0x3dde7b7a),
    selectedColor: Color(
        0x80f37a74), // This is the same red color used for toggle button but with 80% alpha
    shape: StadiumBorder(),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0.0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
);
