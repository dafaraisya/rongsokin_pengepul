// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:rongsokin_pengepul/components/default_navBar.dart';
// import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/enums.dart';
// import 'package:rongsokin_pengepul/models/user_pengepul.dart';
// import 'package:rongsokin_pengepul/screens/history/detail_history.dart';
import 'package:rongsokin_pengepul/screens/history/recent_history_list.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(backButton: true,),
      bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.transaction),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                'RIWAYAT',
                style: TextStyle(
                  color: Color(0xFF1D438A),
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                ),
              ),
              RecentHistorylist()
            ],
          ),
        ),
      ),
    );
  }
}