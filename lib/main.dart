import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rongsokin_pengepul/models/user_pengepul.dart';
// import 'package:rongsokin_pengepul/screens/home/home.dart';
import 'package:rongsokin_pengepul/screens/wrapper.dart';
import 'package:rongsokin_pengepul/services/auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return StreamProvider<UserPengepul?>.value(
    //   value: AuthService().user, 
    //   initialData: null,
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: Wrapper(),
    //   ),
    // );
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rongsokin Pengepul',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat',
        ),
        home: Wrapper(),
      ),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Rongsokin',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: Wrapper(),
    // );
  }
}
