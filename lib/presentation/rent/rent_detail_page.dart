import 'package:car_rent_app/core/app_theme.dart';
import 'package:car_rent_app/data/db/db_dummy.dart';
import 'package:car_rent_app/data/model/car.dart';
import 'package:car_rent_app/data/model/rent_transaction.dart';
import 'package:car_rent_app/data/model/user.dart';
import 'package:car_rent_app/data/repository/rent_transaction_repository.dart';
import 'package:car_rent_app/data/repository/user_repository.dart';
import 'package:car_rent_app/presentation/rent/rent_edit_page.dart';
import 'package:flutter/material.dart';

class RentDetailPage extends StatefulWidget {
  final RentTransaction transaction;
  const RentDetailPage({super.key, required this.transaction});

  @override
  State<RentDetailPage> createState() => _RentDetailPageState();
}

class _RentDetailPageState extends State<RentDetailPage> {
  final _repo = RentTransactionRepository();
  final _userRepo = UserRepository();

  late Car _car;
  User? _user;

  @override
  void initState() {
    super.initState();
    _car = DbDummy.getCarById(widget.transaction.carId);
    _loadData();
  }

  void _loadData() async {
    final user = await _userRepo.getUserById(widget.transaction.userId);

    if (mounted) {
      setState(() {
        _user = user;
      });
    }
  }

  void _cancel() async {
    final bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Batalkan Sewa"),
        content: const Text(
          "Apakah Anda yakin ingin membatalkan pesanan sewa ini?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Tidak"),
          ),
          
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Ya, batalkan"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final result = await _repo.cancelTransaction(widget.transaction.id!);

      if (mounted && result > 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Pesanan dibatalkan")));
        Navigator.pop(context, true);
      }
    }
  }

  void _edit() async {
    if (_user != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RentEditPage(
            transaction: widget.transaction,
            car: _car,
            user: _user!,
          ),
        ),
      );

      if (result == true && mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tx = widget.transaction;

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Transaksi")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(_car.carImg, height: 150, fit: BoxFit.contain),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: tx.status == 'aktif'
                    ? Colors.green
                    : (tx.status == 'selesai' ? Colors.blue : Colors.red),
              ),
              child: Text(
                tx.status.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              _car.carName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),

            Text(
              "Kategori: ${_car.carType}",
              style: TextStyle(color: Colors.grey.shade600),
            ),

            SizedBox(height: 10),

            const Divider(),

            const SizedBox(height: 10),

            _buildInfo("Nama Penyewa ", _user?.name ?? ""),

            _buildInfo("Tanggal Mulai ", tx.startDate),

            _buildInfo("Lama Sewa ", "${tx.rentDays} Hari"),

            _buildInfo("Harga ", "Rp ${_car.price} / Hari"),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Biaya",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Rp ${tx.totalPrice}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            if (tx.status == 'aktif') ...[
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _edit,
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Sewa"),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _cancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Batalkan Sewa"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
