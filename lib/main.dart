import 'package:flutter/material.dart';
import 'package:fluttertruefalse/presentation/bloc_wrapper/bloc_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BlocWrapper());
  }
}
