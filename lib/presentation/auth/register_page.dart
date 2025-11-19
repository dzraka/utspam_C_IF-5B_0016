import 'package:car_rent_app/presentation/auth/login_page.dart';
import 'package:car_rent_app/utils.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Text(
                  "DAFTAR",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    SizedBox(height: 10),

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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    SizedBox(height: 10),

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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    SizedBox(height: 10),

                    // nik
                    TextFormField(
                      controller: _nikCtr,
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    SizedBox(height: 10),

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
                          return "hanya boleh huruf, angka, dan underscore";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text("Username"),
                        hintText: "masukkan username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

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

                    SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            grPush(context, LoginPage());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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
                          child: const Text("Masuk"),
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
