import 'package:car_rent_app/presentation/home_page.dart';
import 'package:car_rent_app/presentation/profle_page.dart';
import 'package:car_rent_app/presentation/rental_history_page.dart';
import 'package:flutter/material.dart';

class GRNavigator extends StatefulWidget {
  final int userId;
  const GRNavigator({super.key, required this.userId});

  @override
  State<GRNavigator> createState() => _GRNavigatorState();
}

class _GRNavigatorState extends State<GRNavigator> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      RentalHistoryPage(),
      HomePage(userId: widget.userId),
      ProfilePage(),
    ];
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
            label: "Profil",
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
      body: pages[_currentIndex],
    );
  }
}
