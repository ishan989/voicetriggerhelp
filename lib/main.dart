import 'package:call_module/background.dart';
import 'package:flutter/material.dart';
import 'package:call_module/firstpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(), // Use the modified FirstPage
    );
  }
}