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
      await DatabaseService(uid: user.uid).createUserData(username, address, birthDate, phoneNumber);
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

  Future signOut() async {
    try{
      return await firebaseAuth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
  
  Future updateTerimaRequests(String idDocument) async{
    try{
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('requests').doc(idDocument).get(); 
      dynamic jsonDocument = documentSnapshot.data();
      if(jsonDocument['diambil'] == false ) {
        final user = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser : null;
        await DatabaseService(uid: user?.uid ?? null).updateTerimaRequests(idDocument);
        return user;
      } else {
        return null;
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future updateTolakRequests(List<String> tolakRequests) async{
    try{
      final user = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser : null;
      await DatabaseService(uid: user?.uid ?? null).updateTolakRequests(tolakRequests);
      return user;
    }catch(e){
      print(e.toString());
    }
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }
  
  Stream<User> get user => firebaseAuth.authStateChanges().map((event) => event!);

}
