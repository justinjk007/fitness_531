import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart'; // To sign in with Google and check sign in status

class QueryHelper {
  // Return the full set of the max reps for all activity
  static Future<List<DocumentSnapshot>> getMaxRepListFromDatabase() async {
    List<DocumentSnapshot> list;
    QuerySnapshot querySnapshots;
    if (await AuthHelper.checkIfUserIsLoggedIn()) {
      String userId = await AuthHelper.getUserID();
      querySnapshots = await Firestore.instance
          .collection("users/max_reps/$userId") // subcollection
          .orderBy("date", descending: true) // new entries first
          .limit(1)
          .getDocuments(); // Get Documents not as a stream
      list = querySnapshots.documents; // Make snapshots into a list
      return (list ?? null);
    } else {
      return null;
    }
  }
}
