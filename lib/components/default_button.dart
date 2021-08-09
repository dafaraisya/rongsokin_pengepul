import 'package:flutter/material.dart';
import 'package:rongsokin_pengepul/constant.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0XFFFFC233)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            )
          )
        ),
        onPressed: press!,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 18,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
