import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/screens/history/detail_history.dart';

var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');
class RecentHistorylist extends StatefulWidget {
  const RecentHistorylist({ Key? key }) : super(key: key);

  @override
  State<RecentHistorylist> createState() => _RecentHistorylistState();
}

class _RecentHistorylistState extends State<RecentHistorylist> {
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserPengepul?>(context);
    final user = FirebaseAuth.instance.currentUser!;
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection("requests")
          // .where("userPengepulId", isEqualTo: user?.uid ?? null)
          .where("userPengepulId", isEqualTo: user.uid)
          .orderBy('documentId', descending: true)
          .snapshots(),
        builder: (context,  AsyncSnapshot<QuerySnapshot>snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data!.docs.length == 0) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    Icon(Icons.warning_amber_outlined, size: 60, color: Colors.yellow,),
                    SizedBox(height: 50,),
                    Text(
                      'Tidak Ada Riwayat',
                      style: kHeaderText,
                      textAlign: TextAlign.center,
                    ),   
                    SizedBox(height: 200,),
                  ],
                ),
              );
            }
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot docSnapshot = snapshot.data!.docs[index]; 
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                      return DetailHistory(
                        documentId: docSnapshot["documentId"],
                        userId: docSnapshot["userId"],
                        total: docSnapshot["total"]
                      );
                    }));
                  },
                  child: HistoryContent(
                    name: snapshot.data!.docs[index]['namaUser'], 
                    address: docSnapshot["lokasi"].length > 0 ? docSnapshot["lokasi"] : null, 
                    price: '${currency.format(docSnapshot["total"])}', 
                    date: docSnapshot["tanggal"]
                  )
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
}

class HistoryContent extends StatelessWidget {
  final String name;
  final String address;
  final String price;
  final Timestamp date;

  HistoryContent({
    required this.name,
    required this.address,
    required this.price,
    required this.date,
  });

  String formattedDate (date) {      
    dynamic dateData = date;
    final birthDate = DateTime.fromMicrosecondsSinceEpoch(dateData.microsecondsSinceEpoch);
    String formattedDate = DateFormat('dd MMMM yyyy').format(birthDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
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
                    formattedDate(date),
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