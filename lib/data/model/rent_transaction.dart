// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RentTransaction {
  final int? id;
  final int userId;
  final int carId;
  final String status;
  final int pricePerDay;
  final int rentDays;
  final String startDate;
  final int totalPrice;
  RentTransaction({
    this.id,
    required this.userId,
    required this.carId,
    required this.status,
    required this.pricePerDay,
    required this.rentDays,
    required this.startDate,
    required this.totalPrice,
  });

  RentTransaction copyWith({
    int? id,
    int? userId,
    int? carId,
    String? status,
    int? pricePerDay,
    int? rentDays,
    String? startDate,
    int? totalPrice,
  }) {
    return RentTransaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      carId: carId ?? this.carId,
      status: status ?? this.status,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      rentDays: rentDays ?? this.rentDays,
      startDate: startDate ?? this.startDate,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'carId': carId,
      'status': status,
      'pricePerDay': pricePerDay,
      'rentDays': rentDays,
      'startDate': startDate,
      'totalPrice': totalPrice,
    };
  }

  factory RentTransaction.fromMap(Map<String, dynamic> map) {
    return RentTransaction(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] as int,
      carId: map['carId'] as int,
      status: map['status'] as String,
      pricePerDay: map['pricePerDay'] as int,
      rentDays: map['rentDays'] as int,
      startDate: map['startDate'] as String,
      totalPrice: map['totalPrice'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RentTransaction.fromJson(String source) =>
      RentTransaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RentTransaction(id: $id, userId: $userId, carId: $carId, status: $status, pricePerDay: $pricePerDay, rentDays: $rentDays, startDate: $startDate, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(covariant RentTransaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.carId == carId &&
        other.status == status &&
        other.pricePerDay == pricePerDay &&
        other.rentDays == rentDays &&
        other.startDate == startDate &&
        other.totalPrice == totalPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        carId.hashCode ^
        status.hashCode ^
        pricePerDay.hashCode ^
        rentDays.hashCode ^
        startDate.hashCode ^
        totalPrice.hashCode;
  }
}
