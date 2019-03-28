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
  // Return 'week''s value or false if it doesn't exist
  static Future<bool> getWeek(String week) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // week will be strings like 'week1' , 'week2' ...
    return prefs.getBool(week) ?? false; // If no data exist return false
  }

  // Save 'week''s status to disk
  static Future<bool> setWeek(String week, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(week, value);
  }

  // Save inverse of weeks status, so save false if true is in memory
  static Future<bool> toggleWeek(String week) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool(week) ?? false; // If no data exist return false
    return prefs.setBool(week, !val);
  }
}
