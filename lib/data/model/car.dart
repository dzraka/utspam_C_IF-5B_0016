// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Car {
  final int? id;
  final String carName;
  final String carType;
  final String carImg;
  final int price;
  Car({
    this.id,
    required this.carName,
    required this.carType,
    required this.carImg,
    required this.price,
  });

  Car copyWith({
    int? id,
    String? carName,
    String? carType,
    String? carImg,
    int? price,
  }) {
    return Car(
      id: id ?? this.id,
      carName: carName ?? this.carName,
      carType: carType ?? this.carType,
      carImg: carImg ?? this.carImg,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'carName': carName,
      'carType': carType,
      'carImg': carImg,
      'price': price,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'] != null ? map['id'] as int : null,
      carName: map['carName'] as String,
      carType: map['carType'] as String,
      carImg: map['carImg'] as String,
      price: map['price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) =>
      Car.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Car(id: $id, carName: $carName, carType: $carType, carImg: $carImg, price: $price)';
  }

  @override
  bool operator ==(covariant Car other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.carName == carName &&
        other.carType == carType &&
        other.carImg == carImg &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        carName.hashCode ^
        carType.hashCode ^
        carImg.hashCode ^
        price.hashCode;
  }
}
