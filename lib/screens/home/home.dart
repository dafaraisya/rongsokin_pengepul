import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:rongsokin_pengepul/components/default_navBar.dart';
import 'package:rongsokin_pengepul/components/request_notification.dart';
import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/enums.dart';

List<String> tolakRequests = [];
bool isSwitched = false;
String statusPengepul = 'Pengepul Tidak Aktif';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// Component Nav Bar masih statis
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //get data user from firebase
    final user = FirebaseAuth.instance.currentUser != null
        ? FirebaseAuth.instance.currentUser
        : null;
    var db = FirebaseFirestore.instance;
    final dataProfileUser =
        db.collection("usersPengepul").doc(user?.uid ?? null).snapshots();

    return Scaffold(
      appBar: DefaultAppBar(),
      bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.home),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFFFC233),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  statusPengepul,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;      
                      if(isSwitched == false ){
                        statusPengepul = 'Pengepul Tidak Aktif';
                      } else {
                        statusPengepul = 'Pengepul Aktif';
                      }          
                    });
                  },
                  activeTrackColor: Colors.grey[300],
                  activeColor: kPrimaryColor,
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: user == null ? Container() : StreamBuilder(
            stream: dataProfileUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                tolakRequests.clear();
                for (var i = 0; i < (snapshot.data as dynamic)["tolakRequests"].length; i++) {
                  tolakRequests.add((snapshot.data as dynamic)["tolakRequests"][i]);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFC233),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo,',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              (snapshot.data as dynamic)["username"],
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 23),
                    // Profile Text
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'PROFILE',
                        style: TextStyle(
                          color: Color(0xFF1D438A),
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    // Profile Container
                    Container(
                      height: 155,
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 20),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              // Class ProfileContent ada di bawah
                              ProfileContent(
                                asset:
                                    'assets/images/total_transaction.png',
                                text: 'Total\nTransaksi',
                                amount: (snapshot.data
                                        as dynamic)["totalTransaction"]
                                    .toString(),
                              ),
                              ProfileContent(
                                asset: 'assets/images/rating.png',
                                text: 'Rating',
                                amount:
                                    (snapshot.data as dynamic)["rating"]
                                        .toString(),
                              ),
                              ProfileContent(
                                asset: 'assets/images/point.png',
                                text: 'Rongsok\nPoint',
                                amount: (snapshot.data as dynamic)["poin"]
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 23),
                    // Text Riwayat
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'RIWAYAT',
                        style: TextStyle(
                          color: Color(0xFF1D438A),
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    // Class HistoryContent ada di bawah
                    HistoryContent(
                      name: 'Nisa Sabyan',
                      weight: 2,
                      address: 'Jl Panderman Gang 5',
                      price: 'Rp100.000,00',
                      date: '27 Agustus 2021',
                    ),
                    HistoryContent(
                      name: 'Nisa Sabyan',
                      weight: 2,
                      address: 'Jl Panderman Gang 5',
                      price: 'Rp100.000,00',
                      date: '27 Agustus 2021',
                    ),
                    HistoryContent(
                      name: 'Nisa Sabyan',
                      weight: 2,
                      address: 'Jl Panderman Gang 5',
                      price: 'Rp100.000,00',
                      date: '27 Agustus 2021',
                    ),
                    SizedBox(height: 50),
                    isSwitched ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                        .collection("requests")
                        .where("diambil", isEqualTo: false)
                        .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
                              if(tolakRequests.contains(docSnapshot["documentId"])) {
                                print('sudah diabaikan pengepul');
                              } else {
                                  return ShowRequestDialog(
                                    documentId: docSnapshot["documentId"],
                                    index: index,
                                  );
                              }
                              return Container();
                            },
                          );
                        }
                        return Container();
                      }
                    ) : Container()
                  ],
                );
              }
              return Center(
                child: Text('Loading...'),
              );
            }
          ),
        ),
      ),
    );
  }
}

class HistoryContent extends StatelessWidget {
  final String name;
  final int weight;
  final String address;
  final String price;
  final String date;

  HistoryContent({
    required this.name,
    required this.weight,
    required this.address,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Color(0xFF163570),
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Berat : ' + weight.toString() + ' Kg',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  final String asset;
  final String text;
  final String amount;

  ProfileContent(
      {required this.asset, required this.text, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(asset),
        ),
        SizedBox(height: 6),
        Text(
          amount,
          style: TextStyle(
            color: Color(0xFF1D438A),
            fontFamily: 'Montserrat',
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 13),
        )
      ],
    );
  }
}

class ShowRequestDialog extends StatefulWidget {
  final String documentId;
  final int index;
  const ShowRequestDialog({
    Key? key, required this.documentId, 
    required this.index,
  }) : super(key: key);

  @override
  _ShowRequestDialogState createState() => _ShowRequestDialogState();
}

class _ShowRequestDialogState extends State<ShowRequestDialog> {
  
  void newOrder() {
    Future.delayed(Duration.zero, () async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return RequestNotification(
            documentId: widget.documentId,
            context: context,
            tolakRequests: tolakRequests,
            press: () {},
          );
        },
      ); 
    });
  } 
  
  @override
  void initState() {
    super.initState();
    setState(() {
      newOrder();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container()
      ],
    );
  }
}
