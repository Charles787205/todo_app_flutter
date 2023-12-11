import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database_functions.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        "1035980061651-gm56pji05a9iup6baqsuflgra28sbt5a.apps.googleusercontent.com");

Future<UserCredential> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    ) as GoogleAuthCredential;
    var userCredential = await _auth.signInWithCredential(credential);
    retrieveAndAddIfNoneUser(userCredential);
    return userCredential;
  } catch (error) {
    print("Error signing in with Google: $error");
    return Future.error(error);
  }
}
