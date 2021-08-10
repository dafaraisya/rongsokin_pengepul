// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // DocumentReference documentReference;
  Future updateUserData(String username, String address, Timestamp birthDate, String phoneNumber) async {
    var db = FirebaseFirestore.instance;
    db.collection("usersPengepul").doc(uid).set({
      'username' : username,
      'address' : address,
      'birthDate' : birthDate,
      'phoneNumber' : phoneNumber
    });
  }

  //tambah event
  // Future addEvent(
  //   String eventName, 
  //   String eventDescription, 
  //   String eventLocation, 
  //   Timestamp eventStartDate, 
  //   Timestamp eventEndDate, 
  //   String eventPurpose,
  //   Map<int, String> eventTask, 
  //   Map<int, String> eventRequirement, 
  //   File imageFile
  // ) async {
  //   documentReference = eventCollection.document();    
  //   String downloadUrl = await addEventPhoto(imageFile, documentReference.documentID);
  //   await eventCollection.document(documentReference.documentID).setData({
  //     'eventUploader' : uid,
  //     'eventName' : eventName,
  //     'eventPhoto' : downloadUrl,
  //     'eventDescription' : eventDescription,
  //     'eventLocation' : eventLocation,
  //     'eventStartDate' : eventStartDate,
  //     'eventEndDate' : eventEndDate,
  //     'eventPurpose' : eventPurpose,
  //     'evenTask' : [
  //       for (var entry in eventTask.entries) {          
  //         'id' : entry.key,
  //         'value' : entry.value
  //       }
  //     ],
  //     'eventRequirement' : [
  //       for (var entry in eventRequirement.entries) {          
  //         'id' : entry.key,
  //         'value' : entry.value
  //       }
  //     ]
  //   });
  //} 

  //tambah foto event
  // Future addEventPhoto(File imageFile, String documentID) async {
  //   //ambil nama file dari path file
  //   String fileName = basename(imageFile.path);
  //   //tentukan path file di firebase storage
  //   StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  //   //upload ke firebase storage
  //   StorageUploadTask task = ref.putFile(imageFile);
  //   //cek upload sudah selesai belom
  //   StorageTaskSnapshot snapshot = await task.onComplete;
  //   // dapatkan gambar yang sudah diupload
  //   return await snapshot.ref.getDownloadURL();
  // }

  // Stream<QuerySnapshot> get users {
  //   return userCollection.snapshots();
  // }

  // Future<DocumentSnapshot> getEvents(String id) async {
  //   return await eventCollection.document(id).get();
  // }
}