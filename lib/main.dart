

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_app/screens/login_screen.dart';

void main() async {
  /// 1- TO Initialize the Firebase for ensure binding between flutter widget layer and Firebase plugin /// ///
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// 2- control with movable screen to Up and Down ///
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// 3- control with theme color ///
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),

      /// 4- the first screen display when open app ///
      home: LoginScreen(),
      //   ),
      // );
    );
  }
}


