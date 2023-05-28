import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user
  Future<String> signUpUsers({
    required String email,
    required String password,
    required String username,
    required String fullname,
    required Uint8List file,
  }) async {
    String result = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || fullname.isNotEmpty) {
        //register user
        UserCredential cred =
            await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage("profilePics", file, false);

        // add user to our database
        _firestore.collection('users').doc(cred.user!.uid).set({
          "email": email,
          "username": username,
          "uid": cred.user!.uid,
          "fullname": fullname,
          "followers": [],
          "following": [],
          "profilePhotoUrl": photoUrl,
        });

        //this methods adds random uid by firebase
        // _firestore.collection('users').add({
        //   "email": email,
        //   "username": username,
        //   "uid": cred.user!.uid,
        //   "fullname": fullname,
        //   "followers": [],
        //   "following": [],
        // });

        result = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        result = 'the email is badly formatted';
      } else if (err.code == "weak-password") {
        result = " Your password is weak";
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }
}
