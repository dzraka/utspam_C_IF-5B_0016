// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DbDummy {
  static List<Car> cars = [
    Car(
      name: "Toyota Avanza",
      type: "MPV",
      img: "assets/img/car/toyota-avanza.png",
      price: 350000,
    ),
    Car(
      name: "Mitsubishi Xpander",
      type: "MPV",
      img: "assets/img/car/mitsubishi-xpander.png",
      price: 450000,
    ),
    Car(
      name: "Toyota Innova Reborn",
      type: "MPV Premium",
      img: "assets/img/car/toyota-innova-reborn.png",
      price: 750000,
    ),
    Car(
      name: "Honda Brio",
      type: "City Car",
      img: "assets/img/car/honda-brio.png",
      price: 300000,
    ),
    Car(
      name: "Toyota Agya",
      type: "City Car",
      img: "assets/img/car/toyota-agya.png",
      price: 250000,
    ),
    Car(
      name: "Honda HR-V",
      type: "SUV",
      img: "assets/img/car/honda-hrv.png",
      price: 600000,
    ),
    Car(
      name: "Toyota Fortuner",
      type: "SUV Premium",
      img: "assets/img/car/toyota-fortuner.png",
      price: 1200000,
    ),
    Car(
      name: "Mitsubishi Pajero Sport",
      type: "SUV Premium",
      img: "assets/img/car/mitsubishi-pajero.png",
      price: 1250000,
    ),
    Car(
      name: "Honda Civic Turbo",
      type: "Sedan",
      img: "assets/img/car/honda-civic.png",
      price: 1500000,
    ),
    Car(
      name: "Toyota Hiace",
      type: "Minibus",
      img: "assets/img/car/toyota-hiace.png",
      price: 1100000,
    ),
  ];
}

class Car {
  final int? id;
  final String name;
  final String type;
  final String img;
  final double price;

  Car({
    this.id,
    required this.name,
    required this.type,
    required this.img,
    required this.price,
  });

  Car copyWith({
    int? id,
    String? name,
    String? type,
    String? img,
    double? price,
  }) {
    return Car(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      img: img ?? this.img,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'img': img,
      'price': price,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      type: map['type'] as String,
      img: map['img'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) =>
      Car.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Car(id: $id, name: $name, type: $type, img: $img, price: $price)';
  }

  @override
  bool operator ==(covariant Car other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.type == type &&
        other.img == img &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        img.hashCode ^
        price.hashCode;
  }
}
