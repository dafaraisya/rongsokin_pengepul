import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/constant.dart';

class NotificationAlertDialog extends StatelessWidget {
  const NotificationAlertDialog({
    Key? key,
    required this.context,
    required this.press,
  }) : super(key: key);

  final BuildContext context;
  final VoidCallback? press;

  @override
  Widget build(context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 300.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Jemput Barang", style: kHeaderText),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                height: 10,
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                // onSaved: (newValue) => email = newValue,
                onChanged: (value) {
                  // setState(() {
                  //   email = value;
                  // });
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Detail Lokasi",
                  labelStyle: TextStyle(fontSize: 20, color: kPrimaryColor),
                  hintText: "Asrama Mahasiswa ITS",
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
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                // onSaved: (newValue) => email = newValue,
                onChanged: (value) {
                  // setState(() {
                  //   email = value;
                  // });
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Detail Barang",
                  labelStyle: TextStyle(fontSize: 20, color: kPrimaryColor),
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
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      "Abaikan",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                InkWell(
                  onTap: press,
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(15.0)),
                    ),
                    child: Text(
                      "Ambil",
                      style: TextStyle(color: kPrimaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}