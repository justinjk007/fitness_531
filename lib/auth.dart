import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class FBApi {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseUser firebaseUser;

  FBApi(FirebaseUser user) {
    this.firebaseUser = user;
  }

  static Future<FBApi> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // We are never handling users password, we simply make use of OAuth 2.0
    final FirebaseUser user = await _auth.signInWithCredential(credential);

    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    return FBApi(user);
  }
}

class AuthHelper {
  static Future<bool> loginUser() async {
    final api = await FBApi.signInWithGoogle();
    if (api != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> checkIfUserIsLoggedIn() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getUserID() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String _user;
    user != null ? _user = user.uid.toString() : _user = "null";
    return _user;
  }
}
