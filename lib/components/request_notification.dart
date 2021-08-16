import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/screens/home/home.dart';
import 'package:rongsokin_pengepul/screens/transaction/confirmation_pickup.dart';
import 'package:rongsokin_pengepul/services/auth.dart';

class RequestNotification extends StatelessWidget {
  const RequestNotification({
    Key? key,
    required this.idDocument,
    required this.context,
    required this.press,
    required this.tolakRequests,
  }) : super(key: key);

  final String idDocument;
  final BuildContext context;
  final VoidCallback? press;
  final List<String> tolakRequests;

  @override
  Widget build(context) {
    final AuthService _auth = AuthService();
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 300.0,
        child: Column(
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
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                // onSaved: (newValue) => email = newValue,
                onChanged: (value) {
                  // setState(() {
                  //   email = value;
                  // });
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Detail Lokasi",
                  labelStyle: TextStyle(fontSize: 20, color: kPrimaryColor),
                  hintText: "Asrama Mahasiswa ITS",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                  .collection("requests")
                  .doc(idDocument)
                  .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: (snapshot.data as dynamic)["listBarang"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text((snapshot.data as dynamic)["listBarang"][index]["namaBarang"]),
                                Text((snapshot.data as dynamic)["listBarang"][index]["berat"].toString())
                              ],
                            )
                            
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              )
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async{
                    tolakRequests.add(idDocument);
                    dynamic result = await _auth.updateTolakRequests(tolakRequests);
                    if(result == null) {
                      print('result null');
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 150,
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
                InkWell(
                  onTap: () async{
                    dynamic result = await _auth.updateTerimaRequests(idDocument);
                    if(result == null) {
                      print('sudah diambil');
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return ConfirmationPickUp(idDocument: idDocument,);
                      }));                      
                    }
                  },
                  child: Container(
                    width: 150,
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
              ],
            )
          ],
        ),
      ),
    );
  }
}