import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:rongsokin_pengepul/components/default_navBar.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_pengepul/enums.dart';
import 'package:rongsokin_pengepul/screens/home/home.dart';

var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');
class FinalTransaction extends StatefulWidget {
  const FinalTransaction({
    Key? key, 
    required this.documentId,
    required this.total,
    required this.userId,
    required this.location
  }) : super(key: key);

  final String documentId;
  final String userId;
  final String location;
  final num total;

  @override
  _FinalTransactionState createState() => _FinalTransactionState();
}

class _FinalTransactionState extends State<FinalTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.transaction,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                  .collection('requests')
                  .doc(widget.documentId)
                  .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    print((snapshot.data as dynamic)['selesai']);
                    if((snapshot.data as dynamic)['selesai'] == true) {
                      WidgetsBinding.instance!.addPostFrameCallback(
                        (_) => Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        ),
                      );                      
                    }
                  }
                  // if((snapshot.data as dynamic)["selesai"]) {
                  //   WidgetsBinding.instance!.addPostFrameCallback(
                  //     (_) => Navigator.push(context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Home(),
                  //       ),
                  //     ),
                  //   );
                  // } else {
                  //   return Container();
                  // }
                  return Container();
                }
              ),
              // Detail User Text
              Text(
                'DETAIL USER',
                style: TextStyle(
                  color: Color(0xFF163570),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              //Detail User Container
              Stack(
                alignment: Alignment.center,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.userId)
                      .snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return  Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFC233),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 20, bottom: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      (snapshot.data as dynamic)["username"],
                                      style: TextStyle(                                 
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 26,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          (snapshot.data as dynamic)["phoneNumber"],
                                          style: TextStyle(                                     
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 27,
                                    ),
                                    SizedBox(width: 7),
                                    Flexible(
                                      child: Text(
                                        widget.location,
                                        style: TextStyle(                                  
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: Text('Loading...'),
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'DETAIL BARANG',
                style: TextStyle(
                  color: Color(0xFF163570),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height - 450,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                      .collection("requests")
                      .doc(widget.documentId)
                      .snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        if((snapshot.data as dynamic)["selesai"]){
                          WidgetsBinding.instance!.addPostFrameCallback(
                            (_) => Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: (snapshot.data as dynamic)["listBarang"].length,
                          itemBuilder: (context, index) {
                            return ItemListCard(
                              index : index,
                              kategori : (snapshot.data as dynamic)["listBarang"][index]["kategori"],
                              namaBarang: (snapshot.data as dynamic)["listBarang"][index]["namaBarang"],
                              deskripsi: (snapshot.data as dynamic)["listBarang"][index]["deskripsi"],
                              harga: (snapshot.data as dynamic)["listBarang"][index]["harga"],
                              berat: (snapshot.data as dynamic)["listBarang"][index]["berat"],
                              fotoBarang : (snapshot.data as dynamic)["listBarang"][index]["fotoBarang"],
                            );
                          },
                        );
                      }
                      
                      return Container(
                        child: Text('Loading...'),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${currency.format(widget.total)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemListCard extends StatefulWidget {
  const ItemListCard({
    Key? key,
    required this.index,
    required this.kategori,
    required this.namaBarang,
    required this.deskripsi,
    required this.berat,
    required this.harga,
    required this.fotoBarang,
  }) : super(key: key);

  final int index;
  final String kategori;
  final String namaBarang;
  final String deskripsi;
  final int berat;
  final int harga;
  final String fotoBarang;

  @override
  _ItemListCardState createState() => _ItemListCardState();
}

class _ItemListCardState extends State<ItemListCard> {
  var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: ListTile(
          title: Text(
            widget.namaBarang,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            widget.deskripsi,
            style: TextStyle(
              color: Colors.black,            
              fontSize: 12,
            ),
          ),
          trailing: Container(
            width: 140,
            child: Column(
              children: [
                Text(
                  '${currency.format(widget.harga * widget.berat)}',
                  style: TextStyle(                   
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  widget.berat.toString() + ' Kg',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}