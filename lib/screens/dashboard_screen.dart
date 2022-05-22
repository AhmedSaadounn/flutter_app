import 'package:flutter/material.dart';
import 'package:flutter_app_app/res/custom_colors.dart';
import 'package:flutter_app_app/screens/add_screen.dart';
import 'package:flutter_app_app/widgets/app_bar_title_.dart';
import 'package:flutter_app_app/widgets/item_list.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    /// 1- ui of DashboardScreen ///
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,

        /// 2- to call ui of AppBarTitle class ///
        title: AppBarTitle(),
      ),
      floatingActionButton: FloatingActionButton(
        /// 3- code navigator to AddScreen when click floatingButton to add post ///
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        backgroundColor: CustomColors.firebaseOrange,

        /// 4- ui of floatingButton ///
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),

          /// 5- to call ui of ItemList class and show them in DashboardScreen ///
          child: ItemList(),
        ),
      ),
    );
  }
}