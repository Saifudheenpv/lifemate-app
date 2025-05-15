import 'package:flutter/material.dart';
import 'package:lifemate_app/features/home/home_screen.dart';
import 'package:lifemate_app/features/tasks/tasks_screen.dart';
import 'package:lifemate_app/features/money/money_screen.dart';
import 'package:lifemate_app/features/habits/habits_screen.dart';
import 'package:lifemate_app/features/ai/ai_assistant_screen.dart';
import 'package:lifemate_app/features/welcome/welcome_screen.dart';

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
        '/home': (context) => const HomeScreen(),
        '/tasks': (context) => const TasksScreen(),
        '/money': (context) => const MoneyScreen(),
        '/habits': (context) => const HabitsScreen(),
        '/ai': (context) => const AIAssistantScreen(),
      },
    );
  }
}
