import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/screens/home/home.dart';
import 'package:rongsokin_pengepul/screens/sign_in/sign_in.dart';
import 'package:rongsokin_pengepul/screens/transaction/confirmation_pickup.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ConfirmationPickUp(),
    );
  }
}
