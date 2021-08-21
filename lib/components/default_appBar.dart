import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({ 
    Key? key,
    required this.backButton
  }) : super(key: key);

  final bool backButton;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      automaticallyImplyLeading: backButton ? true : false,
      centerTitle: true,
      toolbarHeight: 80,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage('assets/images/logo_image.png'),
            width: 42,
          ),
          SizedBox(width: 10),
          Image(image: AssetImage('assets/images/logo_name.png'))
        ],
      ),
    );
  }
}
