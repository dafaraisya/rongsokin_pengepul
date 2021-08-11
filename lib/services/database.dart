// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //initialize firestore
  var db = FirebaseFirestore.instance;

  Future createUserData(String username, String address, Timestamp birthDate, String phoneNumber) async {
    db.collection("usersPengepul").doc(uid).set({
      'username' : username,
      'address' : address,
      'birthDate' : birthDate,
      'phoneNumber' : phoneNumber,
      'totalTransaction' : 0,
      'rating' : 0.0,
      'poin' : 0
    });
  }

  Future<DocumentSnapshot> getUsers(String id) async {
    return await db.collection("userPengepul").doc(id).get();
    // final userData = await db.collection("userPengepul").doc(id).snapshots();
    // return userData;
  }
}