import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_pengepul/models/items_model.dart';
import 'package:rongsokin_pengepul/screens/transaction/final_transaction.dart';
import 'package:rongsokin_pengepul/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<String> _splitName = [];
  num total = 0;
  String namaUser = '';

  String? splitUsername(String username) {
    _splitName.addAll(username.split(" "));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        backButton: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () async {
          for (var i = 0; i < listBarang.length; i++) {
            if(listBarang[i]['check'] == false){
              listBarang.removeAt(i);
            }
          }
          final user = FirebaseAuth.instance.currentUser != null
              ? FirebaseAuth.instance.currentUser
              : null;
          final result = DatabaseService(uid: user?.uid ?? null).updateRequest(listBarang, widget.documentId, total);
          if(result == null) {
            print('gagal');
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              listBarang.clear();
              return FinalTransaction(
                documentId: widget.documentId,
                total: total,
                userId: widget.userId,
                location: widget.location,
              );
            }));
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 50,
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
                        if (snapshot.hasData) {
                          splitUsername((snapshot.data as dynamic)["username"]);
                          namaUser = (snapshot.data as dynamic)["username"];
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
                                  InkWell(
                                    onTap: () {
                                      launch(
                                          'tel:${(snapshot.data as dynamic)["phoneNumber"]}');
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _splitName.length <= 1
                                              ? _splitName[0]
                                              : _splitName[0] +
                                                  ' ' +
                                                  _splitName[1],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: _splitName.length <= 1
                                                ? 20
                                                : 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              size: 26,
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              (snapshot.data
                                                  as dynamic)["phoneNumber"],
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
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
                      }),
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
                height: MediaQuery.of(context).size.height - 420,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("requests")
                      .doc(widget.documentId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:
                            (snapshot.data as dynamic)["listBarang"].length,
                        itemBuilder: (context, index) {
                          return ItemListCard(
                              index: index,
                              kategori: (snapshot.data as dynamic)["listBarang"]
                                  [index]["kategori"],
                              namaBarang:
                                  (snapshot.data as dynamic)["listBarang"]
                                      [index]["namaBarang"],
                              deskripsi: (snapshot.data
                                  as dynamic)["listBarang"][index]["deskripsi"],
                              harga: (snapshot.data as dynamic)["listBarang"]
                                  [index]["harga"],
                              hargaPerItem:
                                  (snapshot.data as dynamic)["listBarang"]
                                      [index]["hargaPerItem"],
                              berat: (snapshot.data as dynamic)["listBarang"]
                                  [index]["berat"],
                              fotoBarang:
                                  (snapshot.data as dynamic)["listBarang"]
                                      [index]["fotoBarang"],
                              total: (num tot) {
                                setState(() {
                                  total = tot;
                                });
                              });
                        },
                      );
                    } else {
                      return Center(
                        child: Container(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    // return Container(
                    //   child: Text('Loading...'),
                    // );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
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
      required this.hargaPerItem,
      required this.fotoBarang,
      required this.total})
      : super(key: key);

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
  String unit = '';
  @override
  void initState() {
    price = widget.harga;
    weight = widget.berat;
    maxWeight = weight;
    listBarang.add({
      'check': false,
      'kategori': widget.kategori,
      'namaBarang': widget.namaBarang,
      'deskripsi': widget.deskripsi,
      'hargaPerItem': widget.hargaPerItem,
      'berat': weight,
      'fotoBarang': widget.fotoBarang
    });
    super.initState();
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Color(0xFFFFC233),
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                        if (_isChecked) {
                          listBarang[widget.index] = ({
                            'check': _isChecked,
                            'kategori': widget.kategori,
                            'namaBarang': widget.namaBarang,
                            'deskripsi': widget.deskripsi,
                            'harga': widget.hargaPerItem * weight,
                            'hargaPerItem': widget.hargaPerItem,
                            'berat': weight,
                            'fotoBarang': widget.fotoBarang
                          });
                          // listBarang.add({
                          //   'check': _isChecked,
                          //   'kategori': widget.kategori,
                          //   'namaBarang': widget.namaBarang,
                          //   'deskripsi': widget.deskripsi,
                          //   'harga': widget.hargaPerItem * weight,
                          //   'hargaPerItem': widget.hargaPerItem,
                          //   'berat': weight,
                          //   'fotoBarang': widget.fotoBarang
                          // });
                          // print(listBarang);
                          widget.total(countTotal()!);
                        } else {
                          // listBarang.removeAt(widget.index);
                          // listBarang.
                          // listBarang.remove(widget.namaBarang);
                          // listBarang.removeWhere((item) => listBarang[widget.index]['namaBarang'] == widget.namaBarang);
                          // listBarang.removeAt(widget.index);
                          listBarang[widget.index] = ({
                            'check': _isChecked,
                            'kategori': widget.kategori,
                            'namaBarang': widget.namaBarang,
                            'deskripsi': widget.deskripsi,
                            'harga': 0,
                            'hargaPerItem': widget.hargaPerItem,
                            'berat': weight,
                            'fotoBarang': widget.fotoBarang
                          });
                          // print(listBarang);
                          // listBarang[widget.index] = {
                          //   'check' : _isChecked,
                          //   'kategori': widget.kategori,
                          //   'namaBarang': widget.namaBarang,
                          //   'deskripsi': widget.deskripsi,
                          //   'harga': 0,
                          //   'hargaPerItem': widget.hargaPerItem,
                          //   'berat': weight,
                          //   'fotoBarang': widget.fotoBarang
                          // };
                          widget.total(countTotal()!);
                        }
                      });
                    },
                  ),
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
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(Icons.close)),
                                )
                              ],
                            );
                          });
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
                          )),
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
                      SizedBox(
                        width: 32,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_isChecked) {
                              weight <= 1 ? 1 : weight--;
                              listBarang[widget.index] = {
                                'check': _isChecked,
                                'kategori': widget.kategori,
                                'namaBarang': widget.namaBarang,
                                'deskripsi': widget.deskripsi,
                                'harga': widget.hargaPerItem * weight,
                                'hargaPerItem': widget.hargaPerItem,
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
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        weight.toString() + unit,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_isChecked) {
                              weight >= maxWeight ? weight : weight++;
                              listBarang[widget.index] = {
                                'check': _isChecked,
                                'kategori': widget.kategori,
                                'namaBarang': widget.namaBarang,
                                'deskripsi': widget.deskripsi,
                                'harga': widget.hargaPerItem * weight,
                                'hargaPerItem': widget.hargaPerItem,
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
                  ),
                  Text(
                    '${currency.format(widget.hargaPerItem * weight)}',
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

// class ItemListCard extends StatefulWidget {
//   const ItemListCard({
//     Key? key,
//     required this.index,
//     required this.kategori,
//     required this.namaBarang,
//     required this.deskripsi,
//     required this.berat,
//     required this.harga,
//     required this.hargaPerItem,
//     required this.fotoBarang,
//     required this.total
//   }) : super(key: key);

//   final int index;
//   final String kategori;
//   final String namaBarang;
//   final String deskripsi;
//   final int berat;
//   final int harga;
//   final int hargaPerItem;
//   final String fotoBarang;
//   final TotalCallback total;

//   @override
//   _ItemListCardState createState() => _ItemListCardState();
// }

// class _ItemListCardState extends State<ItemListCard> {
//   bool _isChecked = false;
//   int price = 1;
//   int weight = 1;
//   int maxWeight = 1;
//   @override
//   void initState() {
//     listBarang.add({
//       'check' : false
//     });
//     price = widget.harga;
//     weight = widget.berat;
//     maxWeight = weight;
//     super.initState();
//   }
//   var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 6,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
//         child: ListTile(
//           leading: Checkbox(
//             checkColor: Colors.white,
//             activeColor: Color(0xFFFFC233),
//             value: _isChecked,
//             onChanged: (bool? value) {
//               setState(() {
//                 _isChecked = value!;
//                 if(_isChecked) {
//                   listBarang[widget.index] = {
//                     'check' : _isChecked,
//                     'kategori': widget.kategori,
//                     'namaBarang': widget.namaBarang,
//                     'deskripsi': widget.deskripsi,
//                     'harga': widget.hargaPerItem * weight,
//                     'hargaPerItem': widget.hargaPerItem,
//                     'berat': weight,
//                     'fotoBarang': widget.fotoBarang
//                   };
//                   widget.total(countTotal()!);
//                 } else {
//                   listBarang[widget.index] = {
//                     'check' : _isChecked,
//                     'kategori': widget.kategori,
//                     'namaBarang': widget.namaBarang,
//                     'deskripsi': widget.deskripsi,
//                     'harga': 0,
//                     'hargaPerItem': widget.hargaPerItem,
//                     'berat': weight,
//                     'fotoBarang': widget.fotoBarang
//                   };
//                   widget.total(countTotal()!);
//                 }
//               });
//             },
//           ),
//           title: Text(
//             widget.namaBarang,
//             style: TextStyle(              
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           subtitle: Text(
//             widget.deskripsi,
//             style: TextStyle(
//               color: Colors.black,            
//               fontSize: 12,
//             ),
//           ),
//           trailing: Container(
//             width: 140,
//             child: Column(
//               children: [
//                 Text(
//                   '${currency.format(widget.hargaPerItem * weight)}',
//                   style: TextStyle(                   
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           if(_isChecked) {
//                             weight <= 1 ? 1 : weight--;
//                             listBarang[widget.index] = {
//                               'check' : _isChecked,
//                               'kategori': widget.kategori,
//                               'namaBarang': widget.namaBarang,
//                               'deskripsi': widget.deskripsi,
//                               'harga': widget.hargaPerItem * weight,
//                               'hargaPerItem': widget.hargaPerItem,
//                               'berat': weight,
//                               'fotoBarang': widget.fotoBarang
//                             };
//                             widget.total(countTotal()!);
//                           }
//                         });
//                       },
//                       child: Container(
//                         height: 25,
//                         width: 25,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Center(child: Icon(Icons.remove)),
//                       ),
//                     ),
//                     Text(
//                       weight.toString() + ' Kg',
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           if(_isChecked) {
//                             weight >= maxWeight ? weight : weight++;
//                             listBarang[widget.index] = {
//                               'check' : _isChecked,
//                               'kategori': widget.kategori,
//                               'namaBarang': widget.namaBarang,
//                               'deskripsi': widget.deskripsi,
//                               'harga': widget.hargaPerItem * weight,
//                               'hargaPerItem': widget.hargaPerItem,
//                               'berat': weight,
//                               'fotoBarang': widget.fotoBarang
//                             };
//                             widget.total(countTotal()!);
//                           }
//                         });
//                       },
//                       child: Container(
//                         height: 25,
//                         width: 25,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Center(child: Icon(Icons.add)),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }