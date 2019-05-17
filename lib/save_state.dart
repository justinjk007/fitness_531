// For reading and writing data to disk with ease
// Comes from the shared_preferences 3rd party library
import 'package:shared_preferences/shared_preferences.dart';

// Every function in the class is static, a class is even here just for cleanliness

// Number of states to remember
//  - active or inactive status of each week (4 values)
//  - active or inactive status of each weeks each lifts (4x4=16 values)
//  - 1 RM weights of each exercise (4 values)

// Some logic

class SaveStateHelper {
  // Return 'week''s value or false if it doesn't exist
  static Future<int> getWeek(String week) async {
    // week will be strings like 'week1' , 'week2' ...
    // Data stored is percent of completness
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(week) ?? 0; // If no data exist return 0
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
      // marked done, so week activities being done should go up by one(25% done)
      prefs.setInt(week, weekStatus + 25);
    } else {
      prefs.setInt(week, weekStatus - 25);
    }
    return prefs.setBool(key, !val); // Inverse activity status
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
    if (val <= 0) val = 0; // We don't take any negatives
    return prefs.setInt(activity, val); // Inverse activity status
  }

  static Future<void> resetAll() async {
    // Reset all activity and completed week status so we can start from the top
    // This is usually done at the end of the 4 weeks streak

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> _activity = ['squat', 'bench', 'deadlift', 'press'];
    // Reset all weeks
    for (var i = 1; i <= 4; i++) {
      prefs.setInt("week$i", null); // Passing in null = delete
    }
    // Reset all activity on all weeks
    for (var i = 1; i <= 4; i++) {
      // Here the key is like week1bench
      _activity.forEach((item) => prefs.setBool("week$i$item", null));
    }
  }
}
