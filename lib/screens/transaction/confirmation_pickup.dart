import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:rongsokin_pengepul/components/default_navBar.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_pengepul/enums.dart';

class ConfirmationPickUp extends StatefulWidget {
  const ConfirmationPickUp({
    Key? key, 
    required this.idDocument
  }) : super(key: key);

  final String idDocument;

  @override
  _ConfirmationPickUpState createState() => _ConfirmationPickUpState();
}

class _ConfirmationPickUpState extends State<ConfirmationPickUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.transaction,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {},
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
                  Container(
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
                                'Pasha Ungu',
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
                                    '+6281658737356',
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
                                  'Jl. Teknik Kimia, Keputih, Kec. Sukolilo, Kota SBY, Jawa Timur 60111',
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
                    .doc(widget.idDocument)
                    .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: (snapshot.data as dynamic)["listBarang"].length,
                        itemBuilder: (context, index) {
                          return ItemListCard(
                            namaBarang: (snapshot.data as dynamic)["listBarang"][index]["namaBarang"],
                            deskripsi: (snapshot.data as dynamic)["listBarang"][index]["deskripsi"],
                            harga: (snapshot.data as dynamic)["listBarang"][index]["harga"],
                            berat: (snapshot.data as dynamic)["listBarang"][index]["berat"],
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
    required this.namaBarang,
    required this.deskripsi,
    required this.berat,
    required this.harga,
  }) : super(key: key);

  final String namaBarang;
  final String deskripsi;
  final int berat;
  final int harga;

  @override
  _ItemListCardState createState() => _ItemListCardState();
}

class _ItemListCardState extends State<ItemListCard> {
  bool _isChecked = true;
  int price = 10000;
  int weight = 1;
  var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    price = widget.harga;
    weight = widget.berat;
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
                          weight <= 1 ? 1 : weight--;
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
                          weight++;
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