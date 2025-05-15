import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/finance/finance_screen.dart';      // FinanceScreen
import 'features/settings/settings_screen.dart';    // SettingsScreen
import 'features/navigation/bottom_nav.dart';

class LifeMateApp extends StatefulWidget {
  const LifeMateApp({super.key});

  @override
  State<LifeMateApp> createState() => _LifeMateAppState();
}

class _LifeMateAppState extends State<LifeMateApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DashboardScreen(),
    const FinanceScreen(),     // Use FinanceScreen here
    const SettingsScreen(),    // Use SettingsScreen here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LifeMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNav(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
