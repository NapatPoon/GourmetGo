import 'package:flutter/material.dart';
import './pages/welcome.dart';
import './pages/login.dart';
import './pages/signup.dart';
import './pages/food_allergy.dart';
import './pages/homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Welcome Page',
        // home: WelcomePage(),
        // home: Login(),
        // home: SignUp(),
        // home: FoodAllergy(),
        home: Homepage());
  }
}
