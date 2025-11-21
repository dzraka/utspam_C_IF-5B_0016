import 'dart:developer';

import 'package:car_rent_app/core/app_theme.dart';
import 'package:car_rent_app/data/model/user.dart';
import 'package:car_rent_app/data/repository/user_repository.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtr = TextEditingController();
  final _nikCtr = TextEditingController();
  final _emailCtr = TextEditingController();
  final _phoneCtr = TextEditingController();
  final _addressCtr = TextEditingController();
  final _usernameCtr = TextEditingController();
  final _pwdCtr = TextEditingController();

  bool isObscure = true;
  final _repo = UserRepository();

  @override
  void dispose() {
    _nameCtr.dispose();
    _nikCtr.dispose();
    _emailCtr.dispose();
    _phoneCtr.dispose();
    _addressCtr.dispose();
    _usernameCtr.dispose();
    _pwdCtr.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameCtr.text.trim();
    final nik = _nikCtr.text.trim();
    final email = _emailCtr.text.trim();
    final phone = _phoneCtr.text.trim();
    final address = _addressCtr.text.trim();
    final username = _usernameCtr.text.trim();
    final password = _pwdCtr.text.trim();

    final user = User(
      name: name,
      email: email,
      nik: nik,
      address: address,
      phone: phone,
      username: username,
      password: password,
    );

    await _repo.registerUser(user);
    if (mounted) {
      log(
        "Registrasi Berhasil: ID=${user.id}, Name=${user.name}, NIK=${user.nik}, Email=${user.email}, Phone=${user.phone}, address=${user.address}, username=${user.username}, password=${user.password}",
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registrasi berhasil")));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Text(
                  "DAFTAR",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkText,
                  ),
                ),
              ),

              SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // nama
                    TextFormField(
                      controller: _nameCtr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "nama tidak boleh kosong";
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return "nama hanya boleh berisi huruf";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text("Nama"),
                        hintText: "masukkan nama",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    SizedBox(height: 16),

                    // email
                    TextFormField(
                      controller: _emailCtr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "email tidak boleh kosong";
                        } else if (!value.contains("@gmail.com")) {
                          return "harus dengan format @gmail.com";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: Text("Email"),
                        hintText: "masukkan email, ex: nama@gmail.com",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    SizedBox(height: 16),

                    // alamat
                    TextFormField(
                      controller: _addressCtr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "masukkan alamat";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Alamat",
                        hintText: "masukkan alamat sesuai KTP",
                        prefixIcon: Icon(Icons.location_city_outlined),
                      ),
                    ),

                    SizedBox(height: 16),

                    // telp
                    TextFormField(
                      controller: _phoneCtr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "nomor telepon tidak boleh kosong";
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "nomor telepon hanya boleh berisi angka";
                        }
                        if (value.length < 10 || value.length > 13) {
                          return "nomor telepon harus terdiri dari 10-13 digit";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        label: Text("Nomor Telepon"),
                        hintText: "masukkan no. telp",
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    SizedBox(height: 16),

                    // nik
                    TextFormField(
                      controller: _nikCtr,
                      maxLength: 16,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "NIK tidak boleh kosong";
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "NIK hanya boleh angka";
                        }
                        if (value.length != 16) {
                          return "NIK harus terdiri dari 16 digit";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text("NIK"),
                        hintText: "masukkan NIK 16 digit",
                        prefixIcon: Icon(Icons.numbers_outlined),
                        counterText: "",
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    SizedBox(height: 16),

                    // username
                    TextFormField(
                      controller: _usernameCtr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "username tidak boleh kosong";
                        }
                        if (value.length < 4) {
                          return "username minimal 4 karakter";
                        }
                        if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                          return "hanya boleh huruf, angka, underscore, dan tanpa spasi";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text("Username"),
                        hintText: "masukkan username",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),

                    SizedBox(height: 16),

                    // password
                    TextFormField(
                      controller: _pwdCtr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password tidak boleh kosong";
                        } else if (value.length < 6) {
                          return "password harus terdiri dari minimal 6 karakter";
                        }
                        return null;
                      },
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        label: Text("Password"),
                        hintText: "masukkan password",
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _register,
                        child: Text("Daftar"),
                      ),
                    ),

                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sudah memiliki akun? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Masuk",
                            style: TextStyle(color: AppTheme.primaryBlue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
