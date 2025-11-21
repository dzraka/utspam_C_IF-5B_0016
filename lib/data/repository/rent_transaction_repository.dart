import 'package:car_rent_app/data/db/rent_transaction_dao.dart';
import 'package:car_rent_app/data/model/rent_transaction.dart';

class RentTransactionRepository {
  final transactionDao = RentTransactionDao();

  Future<int> insertTransaction(RentTransaction transaction) async {
    return await transactionDao.insertTransaction(transaction);
  }

  Future<List<RentTransaction>> getTransactionByUserId(int userId) async {
    return await transactionDao.getTransactionsByUserId(userId);
  }

  Future<int> updateTransaction(int id, RentTransaction transaction) async {
    return await transactionDao.updateTransaction(id, transaction);
  }

  Future<int> cancelTransaction(int id) async {
    return await transactionDao.cancelTransaction(id);
  }

  Future<RentTransaction?> getTransactionById(int id) async {
    return await transactionDao.getTransactionById(id);
  }
}
