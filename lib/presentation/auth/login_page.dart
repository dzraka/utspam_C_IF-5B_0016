import 'dart:developer';

import 'package:car_rent_app/data/repository/user_repository.dart';
import 'package:car_rent_app/gr_navigator.dart';
import 'package:car_rent_app/presentation/auth/register_page.dart';
import 'package:car_rent_app/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtr = TextEditingController();
  final _pwdCtr = TextEditingController();

  bool isObscure = true;
  final _repo = UserRepository();

  @override
  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final username = _usernameCtr.text.trim();
    final password = _pwdCtr.text.trim();

    final user = await _repo.login(username, password);

    if (user != null) {
      log("Login Berhasil: ID=${user.id}, Nama=${user.username}");
      grPushReplace(context, GRNavigator(userId: user.id!));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("username atau password salah")));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(child: Image.asset('assets/img/logo.png', width: 180)),
          SizedBox(height: 20),
          SizedBox(
            height: 40,
            child: Text(
              "Masuk",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // username
                Text("Username", style: TextStyle()),
                SizedBox(height: 10),
                TextFormField(
                  controller: _usernameCtr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "masukkan username";
                    }
                    if (value.length < 4) {
                      return "username minimal 4 karakter";
                    }
                    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                      return "hanya boleh huruf, angka, dan underscore";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "masukkan username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // passwword
                Text("Password", style: TextStyle()),
                SizedBox(height: 10),
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
                    hintText: "masukkan password",
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),

                SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text("Masuk"),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Belum memiliki akun? "),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: const Text("Daftar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
