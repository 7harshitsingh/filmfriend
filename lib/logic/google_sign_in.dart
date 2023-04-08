import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInLogic extends ChangeNotifier {
  final googlesignin = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext ctx) async {
    // showDialog(
    //     context: ctx,
    //     builder: (ctx) {
    //       return CircularProgressIndicator(
    //         color: specialColor,
    //       ).center();
    //     });

    final googleUser = await googlesignin.signIn();
    if (googleUser == null) {
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credentials);

    notifyListeners();
    //Navigator.of(ctx).pop();
  }
}
