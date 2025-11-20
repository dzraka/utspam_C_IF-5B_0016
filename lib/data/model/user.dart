// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int? id;
  final String name;
  final String email;
  final String nik;
  final String address;
  final String phone;
  final String username;
  final String password;
  User({
    this.id,
    required this.name,
    required this.email,
    required this.nik,
    required this.address,
    required this.phone,
    required this.username,
    required this.password,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? nik,
    String? address,
    String? phone,
    String? username,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      nik: nik ?? this.nik,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'nik': nik,
      'address': address,
      'phone': phone,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      email: map['email'] as String,
      nik: map['nik'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(id: $id, name: $name, email: $email, nik: $nik, address: $address, phone: $phone, username: $username, password: $password)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.nik == nik &&
        other.address == address &&
        other.phone == phone &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        nik.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        username.hashCode ^
        password.hashCode;
  }
}
