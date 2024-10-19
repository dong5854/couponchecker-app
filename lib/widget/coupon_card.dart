import 'package:flutter/material.dart';

class CouponCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CouponCard({required this.imageUrl, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
          Text(title),
        ],
      ),
    );
  }
}
