import 'package:flutter/material.dart';

class MoneyScreen extends StatelessWidget {
  const MoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Tracker'),
      ),
      body: const Center(
        child: Text(
          'Money Manager Coming Soon',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
