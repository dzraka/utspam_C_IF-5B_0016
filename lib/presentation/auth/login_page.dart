import 'dart:developer';

import 'package:car_rent_app/core/app_theme.dart';
import 'package:car_rent_app/data/repository/user_repository.dart';
import 'package:car_rent_app/presentation/gr_navigator.dart';
import 'package:car_rent_app/presentation/auth/register_page.dart';
import 'package:car_rent_app/core/utils.dart';
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
  void dispose() {
    _usernameCtr.dispose();
    _pwdCtr.dispose();
    super.dispose();
  }

  @override
  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final username = _usernameCtr.text.trim();
    final password = _pwdCtr.text.trim();

    final user = await _repo.login(username, password);

    if (user != null) {
      log("Login Berhasil: ID=${user.id}, Username=${user.username}");
      grPushReplace(context, GRNavigator(userId: user.id!));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("username atau password salah")));
    }
  }

  @override
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
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
          ),
          SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // username
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

                SizedBox(height: 20),

                // passwword
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
                    onPressed: _login,
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
                onTap: () => grPush(context, RegisterPage()),
                child: const Text(
                  "Daftar",
                  style: TextStyle(color: AppTheme.primaryBlue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
