import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/model/user.dart' as model;

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

        //create user model
        model.User user = model.User(
            email: email,
            username: username,
            uid: cred.user!.uid,
            fullname: fullname,
            followers: [],
            following: []);

        // add user to our database
        _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

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
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  // logging in user function
  Future<String> loginUser({required String email, required String password}) async {
    String result = "Some error occurred.";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred =
            await _auth.signInWithEmailAndPassword(email: email, password: password);
        print(cred.user!.uid);
        result = "Logged in successfully";
      } else {
        result = "Please enter all the fileds";
      }
    }
    // on FirebaseAuthException catch (e) {
    //   if (e.code == "wrong-password") {
    //     result = "Wrong Pass!";
    //   }
    // }
    catch (err) {
      result = err.toString();
    }
    return result;
  }
}
