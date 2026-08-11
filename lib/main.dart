import 'package:clean_app/feature/presentation/layouts/home.dart';
import 'package:clean_app/feature/presentation/pages/Sign_in.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignIn(),
    );
  }
}

