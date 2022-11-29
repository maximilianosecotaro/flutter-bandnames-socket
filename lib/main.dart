import 'package:flutter/material.dart';
import 'package:primera/src/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'home',
      debugShowCheckedModeBanner: false,
      routes: {
        'home': ( _ ) => HomePage(),
      },
    );
  }
}