// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/screens/home/home.dart';
import 'package:rongsokin_pengepul/screens/sign_in/sign_in.dart';
// import 'package:rongsokin_pengepul/screens/transaction/confirmation_pickup.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserPengepul?>(context);
    // if(user == null) {
    //   return Scaffold(
    //     body: SignIn(),
    //   );
    // } else {
    //   return Scaffold(
    //     body: Home(),
    //     // body: RequestTransaction(),
    //   );
    // }
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went error'),
            );
          } else if (snapshot.hasData) {
            return Home();
            // return ConfirmationPickUp(
            //   documentId: '19', 
            //   userId: 'WYAIVuJiDfWU8isZQVEFzLZCP9i2',
            //   location: 'kendal'
            // );
          } else {
            return SignIn();
          }
        },
      ),
    );
  }
}
