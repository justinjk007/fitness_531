// For reading and writing data to disk with ease
// Comes from the shared_preferences 3rd party library
import 'package:shared_preferences/shared_preferences.dart';

// Every function in the class is static, a class is even here just for cleanliness

// Number of states to remember
//  - active or inactive status of each week (4 values)
//  - active or inactive status of each weeks each lifts (4x4=16 values)
//    - With some logic
//    - if week1 is complete all of week1 exercises are complete, hence reducing this data to 4 value
//  - 1 RM weights of each exercise (4 values)
//  - History of 1 RM weights used (infinity)

// Some logic

class SaveStateHelper {
  //////////////////////////////////////////////////////////////////////
  // These are just keywords(keys) of each saved state aka preference //
  //////////////////////////////////////////////////////////////////////
  static final String _week1 = "week1";
  static final String _week2 = "week2";
  static final String _week3 = "week3";
  static final String _week4 = "week4";

  static final String _bench = "bench";
  static final String _press = "press";
  static final String _overhead = "overhead";
  static final String _squat = "squat";

  // Return _week1's value or false if it doesn't exist
  static Future<bool> getWeek1() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_week1) ?? false; // If not _week1 return false
  }

  // Save _week1's status to disk
  static Future<bool> setWeek1(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_week1, value);
  }

  // Return _week2's value or false if it doesn't exist
  static Future<bool> getWeek2() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_week2) ?? false; // If not _week2 return false
  }

  // Save _week2's status to disk
  static Future<bool> setWeek2(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_week2, value);
  }

  // Return _week3's value or false if it doesn't exist
  static Future<bool> getWeek3() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_week3) ?? false; // If not _week3 return false
  }

  // Save _week3's status to disk
  static Future<bool> setWeek3(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_week3, value);
  }

  // Return _week4's value or false if it doesn't exist
  static Future<bool> getWeek4() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_week4) ?? false; // If not _week4 return false
  }

  // Save _week4's status to disk
  static Future<bool> setWeek4(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_week4, value);
  }
}
