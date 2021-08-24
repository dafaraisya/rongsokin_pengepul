import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_pengepul/components/default_button.dart';
import 'package:rongsokin_pengepul/components/failed_screen.dart';
import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/screens/home/home.dart';
import 'package:rongsokin_pengepul/screens/transaction/confirmation_pickup.dart';
import 'package:rongsokin_pengepul/services/auth.dart';

class RequestTransaction extends StatelessWidget {
  const RequestTransaction({ 
    Key? key,
    required this.index,
    required this.documentId,
    required this.context,
    required this.tolakRequests,
  }) : super(key: key);

  final int index;
  final String documentId;
  final BuildContext context;
  final List<String> tolakRequests;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFFAFAFA),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: 290,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () async{
                tolakRequests.add(documentId);
                await _auth.updateTolakRequests(tolakRequests);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
                  return Home();
                }));
              }, 
              child: Icon(Icons.close)
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection("requests")
          .doc(documentId)
          .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Jemput Barang", style: kHeaderText),
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Detail Lokasi',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width ,
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: kPrimaryColor,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text((snapshot.data as dynamic)["lokasi"])
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Detail Barang',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: kPrimaryColor,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: (snapshot.data as dynamic)["listBarang"].length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text((snapshot.data as dynamic)["listBarang"][index]["namaBarang"]),
                                        Text('${currency.format((snapshot.data as dynamic)["listBarang"][index]["harga"])}')
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      DefaultButton(
                        text: 'Terima',
                        press: () async{
                          dynamic result = await _auth.updateTerimaRequests(documentId);
                          if(result == 'sudah diambil') {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              return FailedScreen(message: 'Opps Order sudah diambil\noleh Pengepul Lain');
                            }));
                          } else if(result == 'dibatalkan') {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              return FailedScreen(message: 'Opps Order sudah dibatalkan\noleh user');
                            }));
                          }  
                          else {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return ConfirmationPickUp(
                                documentId: documentId, 
                                userId: (snapshot.data as dynamic)["userId"],
                                location: (snapshot.data as dynamic)["lokasi"]
                              );
                            }));                      
                          }
                        },
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0XFFE6EBEC)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)
                              )
                            )
                          ),
                          onPressed: () async{
                            tolakRequests.add(documentId);
                            await _auth.updateTolakRequests(tolakRequests);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
                              return Home();
                            }));
                          },
                          child: Text(
                            'Tolak',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ), 
                )
              ],
            );
          }
          return Center(
            child: Text('loading...'),
          );
        }
      ),
    );
  }
}