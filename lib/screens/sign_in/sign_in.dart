import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/constant.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                SignInForm(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum punya akun? ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff14213D)),
                    ),
                    GestureDetector(
                        onTap: () {
                        // Navigator.pushNamed(context, SignUpScreen.routeName),
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
                SizedBox(height: 150),
                Text(
                  "Atau login dengan ",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff14213D)),
                ),
                InkWell(
                  onTap: () {
                    // final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                    // provider.login();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Image.asset('assets/icons/google-icon.png'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
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
  bool loading = false;
  final List<String> errors = [];
  // final AuthService _auth = AuthService();

  // void addError({String error}) {
  //   if (!errors.contains(error))
  //     setState(() {
  //       errors.add(error);
  //     });
  // }

  // void removeError({String error}) {
  //   if (errors.contains(error))
  //     setState(() {
  //       errors.remove(error);
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email Pengguna',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => email = newValue,
                  onChanged: (value) {
                    // if (value.isNotEmpty) {
                    //   removeError(error: kEmailNullError);
                    // } else if (emailValidatorRegExp.hasMatch(value)) {
                    //   removeError(error: kInvalidEmailError);
                    // }
                    setState(() {
                      email = value;
                    });
                  },
                  validator: (value) {
                    // if (value.isEmpty) {
                    //   addError(error: kEmailNullError);
                    //   return "";
                    // } else if (!emailValidatorRegExp.hasMatch(value)) {
                    //   addError(error: kInvalidEmailError);
                    //   return "";
                    // }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Masukkan email anda",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Password',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  onSaved: (newValue) => password = newValue,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                    // if (value.isNotEmpty) {
                    //   removeError(error: kPassNullError);
                    // } else if (value.length >= 8) {
                    //   removeError(error: kShortPassError);
                    // }
                    return null;
                  },
                  validator: (value) {
                    // if (value.isEmpty) {
                    //   addError(error: kPassNullError);
                    //   return "";
                    // } else if (value.length < 8) {
                    //   addError(error: kShortPassError);
                    //   return "";
                    // }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Masukkan Password Anda",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                SizedBox(height: 30),
                // FormError(errors: errors),
                SizedBox(height: 10),
                // DefaultButton(
                //   text: "Login",
                //   press: () async {
                //     // dynamic result = await _auth.signInAnon();
                //     // if (result == null) {
                //     //   print('error');
                //     // } else {
                //     //   print('signed in');
                //     //   print(result.uid);
                //     //   Navigator.pushNamed(context, HomeScreen.routeName);
                //     // }
                //     if (_formKey.currentState.validate()) {
                //       _formKey.currentState.save();
                //       KeyboardUtil.hideKeyboard(context);
                //       dynamic result = await _auth.signInWithEmailAndPassword(
                //           email, password);
                //       setState(() {
                //         loading = true;
                //       });
                //       if (result == null) {
                //         loading = false;
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (_) => SignInFailed()));
                //       } else {
                //         Navigator.pushNamed(context, HomeScreen.routeName);
                //       }
                //     }
                //   },
                // ),
              ],
            ),
          );
  }
}
