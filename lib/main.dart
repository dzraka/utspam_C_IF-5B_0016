import 'package:car_rent_app/core/app_theme.dart';
import 'package:car_rent_app/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoRent',
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
