import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:rongsokin_pengepul/components/default_navBar.dart';

class ConfirmationPickUp extends StatefulWidget {
  const ConfirmationPickUp({Key? key}) : super(key: key);

  @override
  _ConfirmationPickUpState createState() => _ConfirmationPickUpState();
}

class _ConfirmationPickUpState extends State<ConfirmationPickUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      bottomNavigationBar: DefaultNavBar(),
    );
  }
}
