import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_pengepul/models/items_model.dart';
import 'package:rongsokin_pengepul/screens/home/home.dart';
import 'package:rongsokin_pengepul/services/database.dart';

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
  List<String> _splitName = [];
  num total = 0;
  String namaUser = '';

  String? splitUsername(String username) {
    _splitName.addAll(username.split(" "));
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserPengepul?>(context);
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: DefaultAppBar(backButton: false,),
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
                        splitUsername((snapshot.data as dynamic)["username"]);
                        namaUser = (snapshot.data as dynamic)["username"];
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
                                      _splitName.length <= 1 ?
                                      _splitName[0] :
                                      _splitName[0] + ' ' + _splitName[1],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: _splitName.length <= 1 ? 20 : 17,
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
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 380,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                        .collection("requests")
                        .doc(widget.documentId)
                        .snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          if((snapshot.data as dynamic)["selesai"]){
                            DatabaseService(uid: user.uid).addPoint(widget.total);
                            WidgetsBinding.instance!.addPostFrameCallback(
                              (_) => Navigator.pushReplacement(context,
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
                                harga: (snapshot.data as dynamic)["listBarang"][index]["harga"] == null ? 0 : (snapshot.data as dynamic)["listBarang"][index]["harga"],
                                berat: (snapshot.data as dynamic)["listBarang"][index]["berat"],
                                fotoBarang : (snapshot.data as dynamic)["listBarang"][index]["fotoBarang"],
                                total: (snapshot.data as dynamic)["total"],
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
  const ItemListCard(
    {Key? key,
    required this.index,
    required this.kategori,
    required this.namaBarang,
    required this.deskripsi,
    required this.berat,
    required this.harga,
    required this.fotoBarang,
    required this.total})
    : super(key: key);

  final int index;
  final String kategori;
  final String namaBarang;
  final String deskripsi;
  final int berat;
  final int harga;
  final String fotoBarang;
  final num total;

  @override
  _ItemListCardState createState() => _ItemListCardState();
}

class _ItemListCardState extends State<ItemListCard> {

  String unit = '';

  @override
  Widget build(BuildContext context) {
    //Set Satuan
    if (getCategory(widget.namaBarang) == 'Elektronik')
      unit = ' unit';
    else if (widget.namaBarang == 'Galon' || widget.namaBarang == 'Tas')
      unit = ' pcs';
    else if (widget.namaBarang == 'Radiator')
      unit = ' set';
    else if (widget.namaBarang == 'Sepatu')
      unit = '';
    else
      unit = ' Kg';

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return Stack(
                            children: [
                              PhotoView(
                                imageProvider: NetworkImage(
                                  widget.fotoBarang,
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.transparent)
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }, 
                                  child: Icon(Icons.close)
                                ),
                              )
                            ],
                          );
                        }
                      );
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.fotoBarang,
                          ),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.namaBarang,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.deskripsi,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Berat : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.berat.toString() + unit,
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Text(
                    '${currency.format(widget.harga)}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
