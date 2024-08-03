import 'package:example/claculator.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyaPP());
}
class MyaPP extends StatelessWidget {
  const MyaPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Claculator(),
    );
  }
}