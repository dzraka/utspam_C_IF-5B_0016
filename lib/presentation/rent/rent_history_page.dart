import 'package:car_rent_app/core/app_theme.dart';
import 'package:car_rent_app/data/db/db_dummy.dart';
import 'package:car_rent_app/data/model/rent_transaction.dart';
import 'package:car_rent_app/data/repository/rent_transaction_repository.dart';
import 'package:car_rent_app/data/repository/user_repository.dart';
import 'package:car_rent_app/presentation/rent/rent_detail_page.dart';
import 'package:flutter/material.dart';

class RentHistoryPage extends StatefulWidget {
  final int userId;
  const RentHistoryPage({super.key, required this.userId});

  @override
  State<RentHistoryPage> createState() => _RentHistoryPageState();
}

class _RentHistoryPageState extends State<RentHistoryPage> {
  final _repo = RentTransactionRepository();
  final _userRepo = UserRepository();
  List<RentTransaction> _transactionList = [];
  String _name = "";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      final tsx = await _repo.getTransactionByUserId(widget.userId);
      final user = await _userRepo.getUserById(widget.userId);

      if (mounted) {
        setState(() {
          _transactionList = tsx;
          _name = user?.name ?? "User";
        });
      }
    } catch (e) {
      debugPrint('Failed to load transactions $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Penyewaan")),
      body: _transactionList.isEmpty
          ? Center(child: Text("Belum ada riwayat transaksi"))
          : ListView.builder(
              padding: const EdgeInsets.all(24.0),
              itemCount: _transactionList.length,
              itemBuilder: (context, index) {
                final tx = _transactionList[index];
                final car = DbDummy.getCarById(tx.carId);
                return InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RentDetailPage(transaction: tx),
                      ),
                    );
                    if (result == true) {
                      _loadData();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppTheme.greyOutline),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                car.carImg,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      car.carName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      "Penyewa: $_name",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),

                                    Text(
                                      "${tx.rentDays} Hari\nMulai: ${tx.startDate}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    const Divider(height: 1),

                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: tx.status == 'aktif'
                                          ? Colors.green
                                          : (tx.status == 'selesai'
                                                ? Colors.blue
                                                : Colors.red),
                                    ),
                                    child: Text(
                                      tx.status.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "Total: Rp ${tx.totalPrice}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
