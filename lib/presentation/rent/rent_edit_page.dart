import 'package:car_rent_app/core/app_theme.dart';
import 'package:car_rent_app/core/utils.dart';
import 'package:car_rent_app/data/model/car.dart';
import 'package:car_rent_app/data/model/rent_transaction.dart';
import 'package:car_rent_app/data/model/user.dart';
import 'package:car_rent_app/data/repository/rent_transaction_repository.dart';
import 'package:car_rent_app/presentation/rent/rent_history_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RentEditPage extends StatefulWidget {
  final RentTransaction transaction;
  final Car car;
  final User user;
  const RentEditPage({
    super.key,
    required this.transaction,
    required this.car,
    required this.user,
  });

  @override
  State<RentEditPage> createState() => _RentEditPageState();
}

class _RentEditPageState extends State<RentEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _daysCtr = TextEditingController();
  final _dateCtr = TextEditingController();

  final _repo = RentTransactionRepository();
  int _totalPrice = 0;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _daysCtr.text = widget.transaction.rentDays.toString();
    _dateCtr.text = widget.transaction.startDate;
    _totalPrice = widget.transaction.totalPrice;
    _daysCtr.addListener(_total);
  }

  @override
  void dispose() {
    _daysCtr.dispose();
    _dateCtr.dispose();
    super.dispose();
  }

  void _total() {
    final daysText = _daysCtr.text;
    if (daysText.isNotEmpty) {
      final days = int.tryParse(daysText) ?? 0;
      setState(() {
        _totalPrice = widget.car.price * days;
      });
    } else {
      setState(() {
        _totalPrice = 0;
      });
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateCtr.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _edit() async {
    if (_formKey.currentState!.validate()) {
      final newRentDays = int.parse(_daysCtr.text);

      final updatedTransaction = widget.transaction.copyWith(
        rentDays: newRentDays,
        startDate: _dateCtr.text,
        totalPrice: _totalPrice,
      );

      final result = await _repo.updateTransaction(
        widget.transaction.id!,
        updatedTransaction,
      );

      if (result > 0 && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data penyewaan berhasil diperbarui!")),
        );

        Navigator.pop(context, true);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gagal memperbarui data")),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  widget.car.carImg,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                widget.car.carName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),

              Text(
                "Kategori: ${widget.car.carType}",
                style: TextStyle(color: Colors.grey.shade600),
              ),

              const SizedBox(height: 20),

              const Divider(),

              const SizedBox(height: 10),

              _buildInfo("Nama Penyewa", widget.user.name),

              _buildInfo("Harga Sewa", "Rp ${widget.car.price} / hari"),

              const SizedBox(height: 20),

              const Text(
                "Detail Sewa",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _daysCtr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "wajib diisi";
                  }
                  final n = int.tryParse(value);
                  if (n == null || n <= 0) {
                    return "harus angka positif";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("Lama Sewa (Hari)"),
                  prefixIcon: const Icon(
                    Icons.timer_outlined,
                    color: AppTheme.primaryBlue,
                  ),
                  suffix: Text("Hari"),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: _dateCtr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "tanggal wajib dipilih";
                  }
                  return null;
                },
                readOnly: true,
                onTap: _pickDate,
                decoration: InputDecoration(
                  label: Text("Tanggal Mulai Sewa"),
                  prefixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),

              SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Biaya:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                    Text(
                      "Rp $_totalPrice",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _edit,
                  child: const Text("Edit"),
                ),
              ),
            ],
          ),
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
