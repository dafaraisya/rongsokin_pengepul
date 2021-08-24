import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_pengepul/components/default_alert_dialog.dart';
import 'package:rongsokin_pengepul/components/default_navBar.dart';
import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/enums.dart';
import 'package:rongsokin_pengepul/screens/sign_in/sign_in.dart';
import 'package:rongsokin_pengepul/services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    //get data from firebase
    final user = FirebaseAuth.instance.currentUser!;
    var db = FirebaseFirestore.instance;
    final dataProfileUser = db.collection("usersPengepul").doc(user.uid).snapshots();

    //format tanggal lahir
    String? formattedDate (dataBirthDate) {      
      dynamic lala = dataBirthDate;
      final birthDate = DateTime.fromMicrosecondsSinceEpoch(lala.microsecondsSinceEpoch);
      String formattedDate = DateFormat('dd MMMM yyyy').format(birthDate);
      return formattedDate;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kSecondaryColor,
        elevation: 0.0,
      ),
      body: StreamBuilder(
        stream: dataProfileUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  height: 130,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        color: kSecondaryColor,
                      ),
                      Positioned(
                        top: 30,
                        left: 20,
                        child: profilePic(),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(
                    (snapshot.data as dynamic)["username"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.star), Text((snapshot.data as dynamic)["rating"].toStringAsFixed(1))],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      user.email!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                profileInfo(Icons.location_on_outlined, (snapshot.data as dynamic)["address"]),
                profileInfo(
                  Icons.date_range_outlined, 
                  formattedDate((snapshot.data as dynamic)["birthDate"])
                ),
                profileInfo(Icons.phone, (snapshot.data as dynamic)["phoneNumber"]),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)))),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ShowAlertDialog(
                              context: context, 
                              alertMessage: "Yakin ingin keluar ?", 
                              press: () async {
                                await _auth.signOut();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                                  return SignIn();
                                }));
                              }
                            );
                          }
                        );
                      },
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Center(
            child: Text("loading..."),
          );
        },
      ),
      bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.profile),
    );
  }

  Container profileInfo(leadingIcon, infoText) {
    return Container(
        child: Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(
              leadingIcon,
              color: kPrimaryColor,
            ),
            onPressed: () => {},
          ),
          Padding(padding: EdgeInsets.only(left: 20.0)),
          Text(
            infoText,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    ]));
  }

  SizedBox profilePic() {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/profile_image.png')),
        ],
      ),
    );
  }
}
