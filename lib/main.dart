import 'package:clean_app/feature/presentation/layouts/home.dart';
import 'package:clean_app/feature/presentation/pages/Sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final String? userEmail = prefs.getString('user_email');

  // ຖ້າມີ email ເກັບໄວ້ໃຫ້ຂ້າມໄປໜ້າ Home ເລີຍ, ຖ້າບໍ່ມີໃຫ້ໄປໜ້າ SignIn
  runApp(MyApp(isLoggedIn: userEmail != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const Home() : const SignIn(),
    );
  }
}