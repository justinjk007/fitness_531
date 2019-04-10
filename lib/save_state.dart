// For reading and writing data to disk with ease
// Comes from the shared_preferences 3rd party library
import 'package:shared_preferences/shared_preferences.dart';

// Every function in the class is static, a class is even here just for cleanliness

// Number of states to remember
//  - active or inactive status of each week (4 values)
//  - active or inactive status of each weeks each lifts (4x4=16 values)
//  - 1 RM weights of each exercise (4 values)

// TODO: History of 1 RM weights used (infinity)

// Some logic

class SaveStateHelper {
  // Return 'week''s value or false if it doesn't exist
  static Future<bool> getWeek(String week) async {
    // week will be strings like 'week1' , 'week2' ...
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int weekStatus = prefs.getInt(week) ?? 0; // If no data exist return 0
    if (weekStatus == 4) {
      return false; // If 4 activities of the week are done, week is done
    } else {
      return true;
    }
  }

  // Return each activities if complete or not status
  static Future<bool> getActivity(String week, String activity) async {
    // week will be strings like 'week1' , 'week2' ...
    // activity will be strings like 'press', 'bench' ...
    String key = week + activity;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? true; // If no data exist return true
  }

  // Save inverse of activities status
  static Future<bool> toggleActivity(String week, String activity) async {
    // week will be strings like 'week1' , 'week2' ...
    // activity will be strings like 'press', 'bench' ...
    String key = week + activity;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool(key) ?? true; // If no data exist return true
    int weekStatus = prefs.getInt(week) ?? 0; // If no data exist return 0
    if (val) {
      // If true, then it was going to be set false meaning the item is being
      // marked done, so week activities being done should go up by one.
      prefs.setInt(week, weekStatus + 1);
    } else {
      prefs.setInt(week, weekStatus - 1);
    }
    return prefs.setBool(key, !val); // Inverse activity status
  }

  static int getMaxRep(String activity) {
    // The maximum rep of each activity stored in lbs
    Map<String, int> stuff = {
      'squat': 215,
      'bench': 125,
      'deadlift': 225,
      'press': 90,
    };
    return stuff[activity] ?? null;
  }

  static Future<int> getMaxRepFromMemory(String activity) async {
    // activity will be strings like 'bench' , 'squat' ...
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int activityStatus =
        prefs.getInt(activity) ?? 0; // If no data exist return 0
    return activityStatus;
  }

  static Future<bool> setMaxRepToMemory(String activity, int val) async {
    // activity will be strings like 'bench' , 'squat' ...
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(activity, val); // Inverse activity status
  }
}
