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

  Future updateTerimaRequests(String idDocument) async {
    db.collection("requests").doc(idDocument).update({
      'diambil' : true,
      'userPengepulId' : uid 
    });
  }

  Future updateTolakRequests(List<String> TolakRequests) async {
    db.collection("usersPengepul").doc(uid).update({
      'tolakRequests' : TolakRequests 
    });
  }

  //update request
  Future updateRequest(List<Map<String, dynamic>> listBarang, String documentId, num total) async{
    print(listBarang);
    return await db.collection('requests').doc(documentId).update({
      'total' : total,
      'listBarang' : [
        for (var i = 0; i < listBarang.length; i++) {
          'check' : listBarang[i]["check"],
          'harga' : listBarang[i]["harga"],
          'berat' : listBarang[i]["berat"],
          'kategori' : listBarang[i]["kategori"],
          'namaBarang' : listBarang[i]["namaBarang"],
          'deskripsi' : listBarang[i]["deskripsi"],
          'fotoBarang' : listBarang[i]["fotoBarang"],
        }
      ],
    });
  }

  Future<DocumentSnapshot> getUsers(String id) async {
    return await db.collection("userPengepul").doc(id).get();
  }
}