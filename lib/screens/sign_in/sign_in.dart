import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/components/default_button.dart';
import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/screens/home/home.dart';
import 'package:rongsokin_pengepul/screens/sign_up/sign_up.dart';
import 'package:rongsokin_pengepul/services/auth.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Spacer(),
            Image.asset("assets/images/logo_name.png"),
            Spacer(),
            Image.asset("assets/images/logo_image.png"),
            Spacer(),
            SignInForm(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum punya akun? ",
                  style: TextStyle(fontSize: 16, color: Color(0xff14213D)),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return SignUp();
                      }));
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff14213D),
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  hintText: "Masukkan password anda",
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
        SizedBox(height: 20,),
        DefaultButton(
          text: "Login",
          press: () async {
            dynamic result = await _auth.signIn(email!, password!);
            print(result);
            if (result == null) {
              print('error');
            } else {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return Home();
              }));
            }
          },
        ),
      ],
    );
  }
}
