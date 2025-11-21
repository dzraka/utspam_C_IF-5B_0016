import 'dart:developer';

import 'package:car_rent_app/data/db/db_helper.dart';
import 'package:car_rent_app/data/model/rent_transaction.dart';

class RentTransactionDao {
  final dbHelper = DbHelper();

  Future<int> insertTransaction(RentTransaction transaction) async {
    final db = await dbHelper.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<RentTransaction>> getTransactionsByUserId(int userId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'transactions',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );

    for (var map in result) {
      log('User Transaction: ${RentTransaction.fromMap(map).toString()}');
    }

    return result.map((map) => RentTransaction.fromMap(map)).toList();
  }

  Future<int> updateTransaction(int id, RentTransaction transaction) async {
    final db = await dbHelper.database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> cancelTransaction(int id) async {
    final db = await dbHelper.database;
    return await db.update(
      'transactions',
      {'status': 'dibatalkan'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<RentTransaction?> getTransactionById(int id) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return RentTransaction.fromMap(result.first);
    }
    return null;
  }
}
