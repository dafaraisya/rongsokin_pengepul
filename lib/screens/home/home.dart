import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/components/default_appBar.dart';
import 'package:rongsokin_pengepul/components/default_navBar.dart';
import 'package:rongsokin_pengepul/constant.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// Component Nav Bar masih statis
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      bottomNavigationBar: DefaultNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFFFC233),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  'PENGEPUL AKTIF',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Halo to users
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFFFFC233),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo,',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'Joko Sumanto',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 23),
              // Profile Text
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'PROFILE',
                  style: TextStyle(
                    color: Color(0xFF1D438A),
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Profile Container
              Container(
                height: 155,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Class ProfileContent ada di bawah
                        ProfileContent(
                          asset: 'assets/images/total_transaction.png',
                          text: 'Total\nTransaksi',
                          amount: '15',
                        ),
                        ProfileContent(
                          asset: 'assets/images/rating.png',
                          text: 'Rating',
                          amount: '4.9',
                        ),
                        ProfileContent(
                          asset: 'assets/images/point.png',
                          text: 'Rongsok\nPoint',
                          amount: '140',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 23),
              // Text Riwayat
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'RIWAYAT',
                  style: TextStyle(
                    color: Color(0xFF1D438A),
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Class HistoryContent ada di bawah
              HistoryContent(
                name: 'Nisa Sabyan',
                weight: 2,
                address: 'Jl Panderman Gang 5',
                price: 'Rp100.000,00',
                date: '27 Agustus 2021',
              ),
              HistoryContent(
                name: 'Nisa Sabyan',
                weight: 2,
                address: 'Jl Panderman Gang 5',
                price: 'Rp100.000,00',
                date: '27 Agustus 2021',
              ),
              HistoryContent(
                name: 'Nisa Sabyan',
                weight: 2,
                address: 'Jl Panderman Gang 5',
                price: 'Rp100.000,00',
                date: '27 Agustus 2021',
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryContent extends StatelessWidget {
  final String name;
  final int weight;
  final String address;
  final String price;
  final String date;

  HistoryContent({
    required this.name,
    required this.weight,
    required this.address,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
                  Text(
                    'Berat : ' + weight.toString() + ' Kg',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                    date,
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

class ProfileContent extends StatelessWidget {
  final String asset;
  final String text;
  final String amount;

  ProfileContent(
      {required this.asset, required this.text, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(asset),
        ),
        SizedBox(height: 6),
        Text(
          amount,
          style: TextStyle(
            color: Color(0xFF1D438A),
            fontFamily: 'Montserrat',
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 13),
        )
      ],
    );
  }
}
