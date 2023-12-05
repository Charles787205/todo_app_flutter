import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

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
