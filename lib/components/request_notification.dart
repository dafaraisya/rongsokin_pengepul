import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_pengepul/components/failed_screen.dart';
import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/screens/transaction/confirmation_pickup.dart';
import 'package:rongsokin_pengepul/services/auth.dart';

class RequestNotification extends StatelessWidget {
  const RequestNotification({
    Key? key,
    required this.documentId,
    required this.context,
    required this.tolakRequests,
  }) : super(key: key);

  final String documentId;
  final BuildContext context;
  final List<String> tolakRequests;

  @override
  Widget build(context) {
    var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    final AuthService _auth = AuthService();
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 300.0,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
            .collection("requests")
            .doc(documentId)
            .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Jemput Barang", style: kHeaderText),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      height: 10,
                      thickness: 2,
                    ),
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
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async{
                            tolakRequests.add(documentId);
                            await _auth.updateTolakRequests(tolakRequests);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              "Abaikan",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async{
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
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius:
                                  BorderRadius.only(bottomRight: Radius.circular(15.0)),
                            ),
                            child: Text(
                              "Ambil",
                              style: TextStyle(color: kPrimaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
            return Center(
              child: Text('Loading...'),
            );
          }
        ),
      ),
    );
  }
}