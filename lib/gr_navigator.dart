import 'package:car_rent_app/presentation/home_page.dart';
import 'package:car_rent_app/presentation/setting_page.dart';
import 'package:car_rent_app/rental_history_page.dart';
import 'package:flutter/material.dart';

class GRNavigator extends StatefulWidget {
  const GRNavigator({super.key});

  @override
  State<GRNavigator> createState() => _GRNavigatorState();
}

class _GRNavigatorState extends State<GRNavigator> {
  int _currentIndex = 1;
  List<Widget> pages = [RentalHistoryPage(), HomePage(), SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => _currentIndex = value),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat",
            activeIcon: Icon(Icons.history),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Beranda",
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Pengaturan",
            activeIcon: Icon(Icons.settings),
          ),
        ],
      ),
      body: pages[_currentIndex],
    );
  }
}
