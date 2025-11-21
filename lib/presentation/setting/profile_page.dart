import 'package:car_rent_app/data/model/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3C4048),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 10),
            Text(
              user.username,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildInfoCard("Nama Lengkap", user.name, Icons.person),
            _buildInfoCard("NIK", user.nik, Icons.numbers),
            _buildInfoCard("Alamat", user.address, Icons.location_city),
            _buildInfoCard("Nomor Telepon", user.phone, Icons.phone),
            _buildInfoCard("Email", user.email, Icons.email),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
