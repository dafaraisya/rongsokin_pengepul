import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color(0XFF14213D);
const kSecondaryColor = Color(0XFFFFC233);
const kHeaderText = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 20,
  fontFamily: 'Montserrat Regular'
);
const kSubHeaderText = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 16,
  fontFamily: 'Montserrat Regular'
);
const kParagraphText = TextStyle(
  color: Colors.black,
  fontSize: 14,
  fontFamily: 'Montserrat Regular'
);
var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');
