import 'package:car_rent_app/core/app_theme.dart';
import 'package:car_rent_app/data/model/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primaryBlue, width: 2),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade100,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: AppTheme.primaryBlue,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              user.username,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            _buildInfoCard("Nama Lengkap", user.name, Icons.person_outline),

            _buildInfoCard("NIK", user.nik, Icons.numbers_outlined),

            _buildInfoCard(
              "Alamat",
              user.address,
              Icons.location_city_outlined,
            ),

            _buildInfoCard("Nomor Telepon", user.phone, Icons.phone_outlined),

            _buildInfoCard("Email", user.email, Icons.email_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryBlue),
          ),
          title: Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          subtitle: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.darkText,
            ),
          ),
        ),
      ),
    );
  }
}
