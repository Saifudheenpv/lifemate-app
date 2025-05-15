import 'package:flutter/material.dart';
import 'features/welcome/welcome_screen.dart';
import 'features/home/home_screen.dart'; // ✅ import new screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LifeMate',
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(), // ✅ updated here
      },
    );
  }
}
