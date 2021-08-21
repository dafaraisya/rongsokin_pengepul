import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:rongsokin_pengepul/constant.dart';

class DetailHistory extends StatelessWidget {
  const DetailHistory({ 
    Key? key,
    required this.documentId,
    required this.userId,
    required this.total
  }) : super(key: key);

  final String documentId;
  final String userId;
  final num total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(backButton: true),
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
              StreamBuilder(
                stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/profile_image.png'),
                                  fit: BoxFit.cover,
                                )),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (snapshot.data as dynamic)["username"],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    (snapshot.data as dynamic)["phoneNumber"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
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
                    );
                  }
                  return Center(
                    child: Text('Loading...'),
                  );
                }
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
                        .doc(documentId)
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

  @override
  Widget build(BuildContext context) {
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
                  Container(
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
                        )),
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
                        widget.berat.toString() + ' Kg',
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
