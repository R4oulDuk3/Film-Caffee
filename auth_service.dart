

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
class AuthService{
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

 // AuthService({required this.firebaseAuth});

  Future <User?> signInEmailPassword(String email,String password)async{

    try{
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      //return "Signed in";
      return result.user;
    }catch(e){
      print(e.toString());
      return null;
    }

  }
  Future <User?> register(String email,String password) async{
    try{
      UserCredential result =await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;

    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Stream<User?> get authStateChanges=> firebaseAuth.idTokenChanges();
Future <String> signOut()async{
  try {
    await firebaseAuth.signOut();
    return "Signed out";
  }catch(e) {
    return e.toString();
  }
}



  Future<User?> signInWithGoogle({required BuildContext context}) async {
    //FirebaseAuth auth = FirebaseAuth.instance;
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
        await firebaseAuth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content: 'Error occurred using Google Sign-In. Try again.',
            )
        );
    }
    return user;
  }
}
  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

}