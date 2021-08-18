import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:rongsokin_pengepul/components/default_navBar.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_pengepul/enums.dart';
import 'package:rongsokin_pengepul/screens/transaction/final_transaction.dart';
import 'package:rongsokin_pengepul/services/database.dart';

num total = 0;
typedef TotalCallback = void Function(num tot);
var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');
List<Map<String, dynamic>> listBarang = [];
num? countTotal() {
  total = 0;
  for (var i = 0; i < listBarang.length; i++) {
    if (listBarang[i]["harga"] != null) {
      total += listBarang[i]["harga"];
    }
  }
  return total;
}
class ConfirmationPickUp extends StatefulWidget {
  const ConfirmationPickUp({
    Key? key, 
    required this.documentId,
    required this.userId,
    required this.location,
  }) : super(key: key);

  final String documentId;
  final String userId;
  final String location;

  @override
  _ConfirmationPickUpState createState() => _ConfirmationPickUpState();
}

class _ConfirmationPickUpState extends State<ConfirmationPickUp> {
  num total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.transaction,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () async{
          final user = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser : null;
          for(var i = 0; i < listBarang.length; i++) {
            if (listBarang[i]['check'] == false) {
              listBarang.removeAt(i);
              print(listBarang);
            }
          }
          await DatabaseService(uid: user?.uid ?? null).updateRequest(listBarang, widget.documentId, total);
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return FinalTransaction(documentId: widget.documentId,total: total, userId: widget.userId, location: widget.location,);
          }));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFFFC233),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Ambil Sekarang',
                style: TextStyle(
                  color: Color(0xFF1D438A),
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                        return Container(
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
              Container(
                height: MediaQuery.of(context).size.height - 520,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                    .collection("requests")
                    .doc(widget.documentId)
                    .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
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
                            hargaPerItem: (snapshot.data as dynamic)["listBarang"][index]["hargaPerItem"],
                            berat: (snapshot.data as dynamic)["listBarang"][index]["berat"],
                            fotoBarang : (snapshot.data as dynamic)["listBarang"][index]["fotoBarang"],
                            total: (num tot) {
                              setState(() {
                                total = tot;
                              });
                            }
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
                      '${currency.format(total)}',
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
    required this.hargaPerItem,
    required this.fotoBarang,
    required this.total
  }) : super(key: key);

  final int index;
  final String kategori;
  final String namaBarang;
  final String deskripsi;
  final int berat;
  final int harga;
  final int hargaPerItem;
  final String fotoBarang;
  final TotalCallback total;

  @override
  _ItemListCardState createState() => _ItemListCardState();
}

class _ItemListCardState extends State<ItemListCard> {
  bool _isChecked = false;
  int price = 1;
  int weight = 1;
  int maxWeight = 1;
  @override
  void initState() {
    listBarang.add({
      'check' : false
    });
    price = widget.harga;
    weight = widget.berat;
    maxWeight = weight;
    super.initState();
  }
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
          leading: Checkbox(
            checkColor: Colors.white,
            activeColor: Color(0xFFFFC233),
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value!;
                if(_isChecked) {
                  listBarang[widget.index] = {
                    'check' : _isChecked,
                    'kategori': widget.kategori,
                    'namaBarang': widget.namaBarang,
                    'deskripsi': widget.deskripsi,
                    'harga': widget.hargaPerItem * weight,
                    'berat': weight,
                    'fotoBarang': widget.fotoBarang
                  };
                  widget.total(countTotal()!);
                } else {
                  listBarang[widget.index] = {
                    'check' : _isChecked,
                    'kategori': widget.kategori,
                    'namaBarang': widget.namaBarang,
                    'deskripsi': widget.deskripsi,
                    'harga': 0,
                    'berat': weight,
                    'fotoBarang': widget.fotoBarang
                  };
                  widget.total(countTotal()!);
                }
              });
            },
          ),
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
                  '${currency.format(price * weight)}',
                  style: TextStyle(                   
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if(_isChecked) {
                            weight <= 1 ? 1 : weight--;
                            listBarang[widget.index] = {
                              'check' : _isChecked,
                              'kategori': widget.kategori,
                              'namaBarang': widget.namaBarang,
                              'deskripsi': widget.deskripsi,
                              'harga': widget.hargaPerItem * weight,
                              'berat': weight,
                              'fotoBarang': widget.fotoBarang
                            };
                            widget.total(countTotal()!);
                          }
                        });
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(child: Icon(Icons.remove)),
                      ),
                    ),
                    Text(
                      weight.toString() + ' Kg',
                      style: TextStyle(
                        
                        fontSize: 15,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if(_isChecked) {
                            weight >= maxWeight ? weight : weight++;
                            listBarang[widget.index] = {
                              'check' : _isChecked,
                              'kategori': widget.kategori,
                              'namaBarang': widget.namaBarang,
                              'deskripsi': widget.deskripsi,
                              'harga': widget.hargaPerItem * weight,
                              'berat': weight,
                              'fotoBarang': widget.fotoBarang
                            };
                            widget.total(countTotal()!);
                          }
                        });
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(child: Icon(Icons.add)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}