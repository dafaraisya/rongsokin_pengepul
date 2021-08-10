import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rongsokin_pengepul/services/database.dart';

class AuthService extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future signUp(String email, String password, String username, String address, Timestamp birthDate, String phoneNumber) async{
    setLoading(true);
    try{
      UserCredential authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user!;
      //buat document 
      await DatabaseService(uid: user.uid).updateUserData(username, address, birthDate, phoneNumber);
      setLoading(false);
      return user;
    } on SocketException {
      print('problem with your internet connection');
      setLoading(false);
    } catch(e) {
      print(e.toString());
      setLoading(false);
    }
    notifyListeners(); 
  }

  Future signIn(String email, String password) async{
    setLoading(true);
    try{
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = authResult.user!;
      setLoading(false);
      return user;
    } on SocketException {
      print('problem with your internet connection');
      setLoading(false);
    } catch(e) {
      print(e.toString());
      setLoading(false);
    }
    notifyListeners(); 
  }

  Future signOut() async{
    await firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }
  
  Stream<User> get user => firebaseAuth.authStateChanges().map((event) => event!);

}

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String? errorMessage;
//   //buat user objek dari firebase user
//   // UserPengepul _userFromFirebaseUser(User user) {
//   //   return user = UserPengepul(uid: user.uid);
//   // }
//   //ubah user stream
//   // Stream<User> get user {
//   //   return _auth.onAuthStateChanged
//   //     .map(_userFromFirebaseUser);
//   // }
//   // sign in pake email & password
//   Future signInWithEmailAndPassword(String email, String password) async{
//     try{
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//     }catch(e){
//       print(e.toString());
//       return null;
//     }
//   }

//   // register pake email & password
//   Future registerWithEmailAndPassword(String email, String password, String username) async{
//     try{
//       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       User? user = result.user;

//       //buat document 
//       // await DatabaseService(uid: user.uid).updateUserData(username);
//       // return _userFromFirebaseUser(user);
//     }catch(e){
//       print(e.toString());
//       return null;
//     }
//   }

//   // sign out
//   Future signOut() async {
//     try{
//       return await _auth.signOut();
//     }catch(e){
//       print(e.toString());
//       return null;
//     }
//   }

//   //get user
//   // Future getUser() async {
//   //   var firebaseUser = await FirebaseAuth.instance.currentUser();
//   //   return firebaseUser;
//   // }

//   //add event
//   // Future addEvent(
//   //   String eventName, 
//   //   String eventDescription, 
//   //   String eventLocation, 
//   //   Timestamp eventStartDate, 
//   //   Timestamp eventEndDate, 
//   //   String eventPurpose,
//   //   Map<int, String> eventTask, 
//   //   Map<int, String> eventRequirement,
//   //   File imageFile
//   //   ) async {
//   //   try{
//   //     //buat document 
//   //     var user = await FirebaseAuth.instance.currentUser();
//   //     await DatabaseService(uid: user.uid).addEvent(eventName, eventDescription, eventLocation, eventStartDate, eventEndDate, eventPurpose, eventTask, eventRequirement, imageFile);
//   //     return user;
//   //   }catch(e){
//   //     print(e.toString());
//   //     return null;
//   //   }
//   // }
// }