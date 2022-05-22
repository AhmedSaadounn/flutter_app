import 'package:flutter/material.dart';
import 'package:flutter_app_app/res/custom_colors.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 1- ui of AppBarTitle ///
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// 2- image that placed in appbar ; and change name of image with your image name ///
        Image.asset(
          'asset/book.png',
          height: 20,
        ),
        SizedBox(width: 8),
        Text(
          'Electronic',
          style: TextStyle(
            color: CustomColors.firebaseAmber,
            fontSize: 18,
          ),
        ),
        Text(
          ' Library',
          style: TextStyle(
            color: CustomColors.firebaseOrange,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

