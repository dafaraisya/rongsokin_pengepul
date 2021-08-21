import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/components/default_button.dart';
import 'package:rongsokin_pengepul/constant.dart';
import 'package:rongsokin_pengepul/screens/home/home.dart';

class FailedScreen extends StatelessWidget {
  const FailedScreen({ 
    Key? key,
    required this.message 
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  Icon(Icons.warning_amber_outlined, size: 60, color: Colors.yellow,),
                  SizedBox(height: 50,),
                  Text(
                    message,
                    style: kHeaderText,
                    textAlign: TextAlign.center,
                  ),   
                  SizedBox(height: 200,),
                ],
              ),
            ),
            DefaultButton(
              text: 'Kembali',
              press: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
                  return Home();
                }));  
              },
            ),
          ],
        ),
      )
    );
  }
}