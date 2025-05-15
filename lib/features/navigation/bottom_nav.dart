import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../home/home_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../finance/finance_screen.dart';
import '../settings/settings_screen.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
  currentIndex: currentIndex,
  onTap: onTap,
  selectedItemColor: AppColors.primary,   // Use your custom primary color here
  unselectedItemColor: Colors.grey,       // You can keep this or customize too
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
    BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Finance'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ],
);

  }
}
