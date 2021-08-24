import 'package:flutter/material.dart';

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }
}