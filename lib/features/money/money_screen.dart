import 'package:flutter/material.dart';

class MoneyScreen extends StatelessWidget {
  const MoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Tracker 💸'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Money screen under construction 🚧',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
