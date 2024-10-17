import 'package:couponchecker/screen/coupon_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color.fromARGB(255, 143, 230, 195), useMaterial3: true),
      home: const CouponCheckerAppBar(),
    );
  }
}

