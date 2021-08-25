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
      'historyTransactions' : [],
      'tolakRequests' : [],
      'totalTransaction' : 0,
      'rating' : 0.0,
      'poin' : 0
    });
  }

  Future updateTerimaRequests(String idDocument) async {
    DocumentSnapshot documentUserPengepul = await FirebaseFirestore.instance.collection('usersPengepul').doc(uid).get(); 
    dynamic jsonUserPengepul = documentUserPengepul.data();
    List<String> historyTransactions = [];
    await db.collection("requests").doc(idDocument).update({
      'diambil' : true,
      'status' : 'diproses pengepul',
      'userPengepulId' : uid,
      'namaUserPengepul' : jsonUserPengepul['username']
    });
    
    for (var i = 0; i < jsonUserPengepul["historyTransactions"].length; i++) {
      historyTransactions.add(jsonUserPengepul["historyTransactions"][i]);
    }
    historyTransactions.add(idDocument);
    await db.collection("usersPengepul").doc(uid).update({
      'historyTransactions' : historyTransactions,
      'totalTransaction' : jsonUserPengepul["totalTransaction"]+1
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
      'status' : 'dikonfirmasi pengepul',
      'total' : total,
      'listBarang' : [
        for (var i = 0; i < listBarang.length; i++) {
          'check' : listBarang[i]["check"],
          'harga' : listBarang[i]["harga"],
          'hargaPerItem' : listBarang[i]["hargaPerItem"],
          'berat' : listBarang[i]["berat"],
          'kategori' : listBarang[i]["kategori"],
          'namaBarang' : listBarang[i]["namaBarang"],
          'deskripsi' : listBarang[i]["deskripsi"],
          'fotoBarang' : listBarang[i]["fotoBarang"],
        }
      ],
    });
  }

  // tambah point
  Future addPoint(num total) async{
    //ambil data poin user
    DocumentSnapshot documentUserPengepul = await FirebaseFirestore.instance.collection('usersPengepul').doc(uid).get(); 
    dynamic jsonUserPengepul = documentUserPengepul.data();

    //tambah poin
    await db.collection('usersPengepul').doc(uid).update({
      'poin' : jsonUserPengepul["poin"]+(total~/10) 
    });
  }

  Future<DocumentSnapshot> getUsers(String id) async {
    return await db.collection("usersPengepul").doc(id).get();
  }
}