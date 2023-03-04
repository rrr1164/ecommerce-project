import 'package:ecommerc/core/utils/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          if(context.mounted) Utilities.showErrorSnackBar(context,'The account already exists with a different credential.');
        } else if (e.code == 'invalid-credential') {
          if(context.mounted) Utilities.showErrorSnackBar(context,'Error occurred while accessing credentials. Try again.');
        }
      } catch (e) {
        if(context.mounted) Utilities.showErrorSnackBar(context,'Error occurred using Google Sign-In. Try again.');
      }
    }

    return user;
  }
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
        await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      if(context.mounted) Utilities.showErrorSnackBar(context,'Error occurred using Google Sign-In. Try again.');
    }
  }
}