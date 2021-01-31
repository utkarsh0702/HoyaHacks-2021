import 'package:flutter/material.dart';
import 'screens/home.dart';
void main(){
  runApp(myApp());
}

// ignore: camel_case_types
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.white,
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}