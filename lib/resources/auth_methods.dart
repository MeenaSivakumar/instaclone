import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import '../models/user.dart' as models;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<models.User> getUserDetails() async {
    User? currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return models.User.fromSnap(snap);
  }

  //signup user
  Future<String> SignUpUser({
    required String name,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occurred";
    try {
      if (email.isNotEmpty ||
          name.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilepics', file, false);

        //add user to database
        models.User user = models.User(
            uid: credential.user!.uid,
            email: email,
            name: name,
            bio: bio,
            photoUrl: photoUrl,
            followers: [],
            following: []);

        await _firestore.collection("users").doc(credential.user!.uid).set(
              user.toJson(),
            );
        res = "suceesful";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "The email is badly formatted";
      } else if (err.code == 'week-password') {
        res = "password should contain special char";
      }
      return res.toString();
    }
    return res;
  }

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = 'some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'suceesful';
      } else {
        res = 'please enter valid email and password';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
