import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:rongsokin_pengepul/components/default_navBar.dart';
import 'package:rongsokin_pengepul/components/request_notification.dart';
// import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/enums.dart';
import 'package:rongsokin_pengepul/models/user_pengepul.dart';
import 'package:rongsokin_pengepul/screens/history/recent_history_list.dart';

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
    final user = Provider.of<UserPengepul?>(context);
    var db = FirebaseFirestore.instance;
    final dataProfileUser = db.collection("usersPengepul").doc(user!.uid).snapshots();

    return Scaffold(
      appBar: DefaultAppBar(backButton: false,),
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
                CupertinoSwitch(
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
                  trackColor: Colors.grey[300],
                  activeColor: Colors.green,
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder(
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
                                    (snapshot.data as dynamic)["rating"].toStringAsFixed(1),
                              ),
                              ProfileContent(
                                asset: 'assets/images/point.png',
                                text: 'Rongsok\nPoint',
                                amount: (snapshot.data as dynamic)["poin"].toString()
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
                    RecentHistorylist(),
                    // ListView.builder(
                    //   physics: NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   itemCount: (snapshot.data as dynamic)["historyTransactions"].length,
                    //   itemBuilder: (context, index) {
                    //     if((snapshot.data as dynamic)["historyTransactions"].length > 0) {
                    //       return HistoryContent(
                    //         name: (snapshot.data as dynamic)["username"], 
                    //         weight: 0, 
                    //         address: 'lala', 
                    //         price: 'lala', 
                    //         date: 'lalal'
                    //       );  
                    //     } 
                    //     return Center(
                    //       child: Text('Loading...'),
                    //     );
                    //   },
                    // ),
                    // HistoryContent(
                    //   name: 'Nisa Sabyan',
                    //   weight: 2,
                    //   address: 'Jl Panderman Gang 5',
                    //   price: 'Rp100.000,00',
                    //   date: '27 Agustus 2021',
                    // ),
                    // HistoryContent(
                    //   name: 'Nisa Sabyan',
                    //   weight: 2,
                    //   address: 'Jl Panderman Gang 5',
                    //   price: 'Rp100.000,00',
                    //   date: '27 Agustus 2021',
                    // ),
                    // HistoryContent(
                    //   name: 'Nisa Sabyan',
                    //   weight: 2,
                    //   address: 'Jl Panderman Gang 5',
                    //   price: 'Rp100.000,00',
                    //   date: '27 Agustus 2021',
                    // ),
                    // HistoryContent(
                    //   name: 'Nisa Sabyan',
                    //   weight: 2,
                    //   address: 'Jl Panderman Gang 5',
                    //   price: 'Rp100.000,00',
                    //   date: '27 Agustus 2021',
                    // ),
                    SizedBox(height: 100),
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
                                return Container();
                              } else if(docSnapshot["dibatalkan"]) {
                                return Container();
                              } else {
                                  return ShowRequestDialog(
                                    documentId: docSnapshot["documentId"],
                                    index: index,
                                  );
                              }
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
