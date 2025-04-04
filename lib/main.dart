import 'package:assignment4/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: HomeScreen.routeName,
      // routes: {
      //   HomeScreen.routeName : (context) => HomeScreen(),
      // },
      home: HomeScreen(key: HomeScreen.homeScreenKey),
    );
  }
}
