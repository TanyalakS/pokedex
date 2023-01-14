import 'package:flutter/material.dart';
import 'package:pokedex/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Pokemon',
        primarySwatch: Colors.red,
        backgroundColor: Colors.red.shade800,
      ),
      home: const SplashScreen(),
    );
  }
}