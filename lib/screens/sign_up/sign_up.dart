import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/components/default_button.dart';
import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/screens/home/home.dart';
import 'package:rongsokin_pengepul/services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? email;
  String? username;
  String? password;
  String? address;
  String? phoneNumber;
  Timestamp? birthDate;
  bool birthDateFilled = false; 
  DateTime selectedBirthDate = DateTime.now();
  final AuthService _auth = AuthService();

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945, 8),
      lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedBirthDate = picked;
        birthDate = Timestamp.fromDate(picked);
        birthDateFilled = true;
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Sign Up'),
      ),
      body: isLoading ? CircularProgressIndicator() : Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (newValue) => email = newValue,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Email",
                      labelStyle: TextStyle(fontSize: 20, color: kPrimaryColor),
                      hintText: "Masukkan email anda",
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
                  SizedBox(height: 30),
                  //Password
                  TextFormField(
                    obscureText: true,
                    onSaved: (newValue) => password = newValue,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 20, color: kPrimaryColor),
                      hintText: "Password min. 6 karakter",
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
                  SizedBox(height: 30),
                  //Nama Pengguna
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => password = newValue,
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Nama Lengkap",
                      labelStyle: TextStyle(fontSize: 20, color: kPrimaryColor),
                      hintText: "Masukkan nama lengkap anda",
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
                  SizedBox(height: 30),
                  //Alamat
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => password = newValue,
                    onChanged: (value) {
                      setState(() {
                        address = value;
                      });
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Alamat",
                      labelStyle: TextStyle(fontSize: 20, color: kPrimaryColor),
                      hintText: "Masukkan alamat lengkap anda",
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
                  SizedBox(height: 30),
                  //birth date
                  buildDateFormField(),
                  SizedBox(height: 30),
                  //No telp
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => password = newValue,
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "No. Telp",
                      labelStyle: TextStyle(fontSize: 20, color: kPrimaryColor),
                      hintText: "Masukkan No. telpon anda",
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
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DefaultButton(
              text: "Daftar",
              press: () async{
                isLoading = true;
                dynamic result = await _auth.signUp(email!, password!, username!, address!, birthDate!, phoneNumber!);
                if(result == null) {
                  print('error');
                } else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return Home();
                  }));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Stack buildDateFormField() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            child: Text(
              birthDateFilled == false ? 'Tahun-Bulan-Tanggal' : "${selectedBirthDate.toLocal()}".split(' ')[0],
              style: TextStyle(color: Color(0xff686868)),
            ),
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: kPrimaryColor))),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                )),
            onPressed: () => _selectBirthDate(context),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          color: Colors.white,
          child: Text('Tanggal lahir'),
        )
      ],
    );
  }
}