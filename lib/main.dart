import 'package:calculatorapp/calculator_screen.dart';
import 'package:flutter/material.dart';

const Color colorDark = Color(0xFF374352);
const Color colorLight = Color(0xFFe6eeff);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator Neumorphism',
      home: Calculator(),
    );
  }
}
