import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:puppymart/component/fooToast.dart';
import 'package:puppymart/model/image_data.dart';

final AuthService authService = AuthService();

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  Future<String> signInWithGoogle(
      BuildContext context, Function onSuccessLogin) async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    Provider.of<ImageData>(context, listen: false)
        .updateAuthProImage(Image.network(currentUser.photoURL));
    return 'signInWithGoogle succeeded: $user';
  }

  Future<void> signOutGoogle(BuildContext context) async {
    await _googleSignIn.signOut();
    Provider.of<ImageData>(context, listen: false).updateNoAuthProImage();
    print("User Sign Out");
  }
}
