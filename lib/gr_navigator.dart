import 'package:car_rent_app/data/model/user.dart';
import 'package:car_rent_app/data/repository/user_repository.dart';
import 'package:car_rent_app/presentation/home_page.dart';
import 'package:car_rent_app/presentation/settings/setting_page.dart';
import 'package:flutter/material.dart';

class GRNavigator extends StatefulWidget {
  final int userId;
  const GRNavigator({super.key, required this.userId});

  @override
  State<GRNavigator> createState() => _GRNavigatorState();
}

class _GRNavigatorState extends State<GRNavigator> {
  int _currentIndex = 0;
  final _repo = UserRepository();
  late Future<User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _repo.getUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            final User activeUser = snapshot.data!;

            final List<Widget> pages = [
              HomePage(userId: widget.userId),
              SettingPage(user: activeUser),
            ];

            return pages[_currentIndex];
          }
          return const Center(child: Text("Gagal Memuat"));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => _currentIndex = value),
        currentIndex: _currentIndex,
        items: [
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
    );
  }
}
