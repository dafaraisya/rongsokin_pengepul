import 'package:flutter/material.dart';

class DefaultNavBar extends StatefulWidget {
  const DefaultNavBar({Key? key}) : super(key: key);

  @override
  _DefaultNavBarState createState() => _DefaultNavBarState();
}

class _DefaultNavBarState extends State<DefaultNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BottomNavigationBar(
        unselectedItemColor: Color(0xFF1D438A),
        selectedItemColor: Color(0xFF1D438A),
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          )
        ],
      ),
    );
  }
}
