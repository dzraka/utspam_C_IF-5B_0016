import 'package:car_rent_app/data/model/user.dart';
import 'package:car_rent_app/presentation/auth/login_page.dart';
import 'package:car_rent_app/presentation/setting/history_page.dart';
import 'package:car_rent_app/presentation/setting/profile_page.dart';
import 'package:car_rent_app/core/utils.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  final User user;
  const SettingPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pengaturan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3C4048),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingItem(
            context,
            title: "Profil Saya",
            icon: Icons.person_outline,
            onTap: () => grPush(context, ProfilePage(user: user)),
          ),
          _buildSettingItem(
            context,
            title: "Riwayat Penyewaan",
            icon: Icons.history,
            onTap: () => grPush(context, HistoryPage()),
          ),
          _buildSettingItem(
            context,
            title: "Keluar",
            icon: Icons.logout_outlined,
            onTap: () => grPushReplace(context, LoginPage()),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: Icon(icon),
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
