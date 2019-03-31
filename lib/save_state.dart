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
    // week will be strings like 'week1' , 'week2' ...
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(week) ?? false; // If no data exist return false
  }

  // Save inverse of weeks status, so save false if true is in memory
  static Future<bool> toggleWeek(String week) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool(week) ?? false; // If no data exist return false
    return prefs.setBool(week, !val);
  }

  // Return each activities if complete or not status
  static Future<bool> getActivity(String week, String activity) async {
    // week will be strings like 'week1' , 'week2' ...
    // activity will be strings like 'press', 'bench' ...
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool weekStatus =
        prefs.getBool(week) ?? false; // If no data exist return false
    if (weekStatus) {
      // Week is marked complete so anything in here should be complete
      return true;
    } else {
      // Week is not marked complete so return activity status
      return prefs.getBool(activity) ?? false; // If no data exist return false
    }
  }

  // Save inverse of activities status
  static Future<bool> toggleActivity(String week, String activity) async {
    // week will be strings like 'week1' , 'week2' ...
    // activity will be strings like 'press', 'bench' ...
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val =
        prefs.getBool(activity) ?? false; // If no data exist return false
    prefs.setBool(activity, !val); // Set activity status

    bool benchStatus = prefs.getBool('bench') ?? false;
    bool squatStatus = prefs.getBool('squat') ?? false;
    bool deadliftStatus = prefs.getBool('deadlift') ?? false;
    bool pressStatus = prefs.getBool('press') ?? false;

    if (benchStatus && squatStatus && deadliftStatus && pressStatus) {
      // if all activities are done this week is done
      return prefs.setBool(week, true);
    } else {
      return prefs.setBool(week, false);
    }
  }

  static int getMaxRep(String activity) {
    // The maximum rep of each activity stored in lbs
    Map<String, int> stuff = {
      'bench': 125,
      'press': 90,
      'deadlift': 225,
      'squat': 215,
    };
    return stuff[activity] ?? null;
  }
}
