import 'package:flutter/material.dart';
import '../app/brand.dart';
import 'screens.dart';

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pelkora',
      theme: ThemeData(
        scaffoldBackgroundColor: cBg,
        primaryColor: cAccent,
      ),
      home: const PelkoraMainScreen(),
    );
  }
}
