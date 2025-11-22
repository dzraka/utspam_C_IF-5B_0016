import 'package:car_rent_app/core/app_theme.dart';
import 'package:car_rent_app/data/model/user.dart';
import 'package:car_rent_app/presentation/auth/login_page.dart';
import 'package:car_rent_app/presentation/rent/rent_history_page.dart';
import 'package:car_rent_app/presentation/setting/profile_page.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  final User user;
  const SettingPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pengaturan")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingItem(
            context,
            title: "Profil Saya",
            icon: Icons.person_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(user: user),
                ),
              );
            },
          ),

          _buildSettingItem(
            context,
            title: "Riwayat Penyewaan",
            icon: Icons.history,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RentHistoryPage(userId: user.id!),
                ),
              );
            },
          ),

          _buildSettingItem(
            context,
            title: "Keluar",
            icon: Icons.logout_outlined,
            isLogout: true,
            onTap: () async {
              final bool? confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Konfirmasi"),
                  content: const Text("Apakah anda yakin ingin keluar?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text("Batal"),
                    ),

                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Ya, keluar"),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                }
              }
            },
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
    bool isLogout = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isLogout
                    ? Colors.redAccent.withValues(alpha: 0.1)
                    : AppTheme.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isLogout ? Colors.redAccent : AppTheme.primaryBlue,
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: isLogout ? Colors.redAccent : AppTheme.darkText,
              ),
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
