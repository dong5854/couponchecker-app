import 'package:flutter/material.dart';

class CouponCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String expireAt;
  final bool isUsed;

  const CouponCard({required this.imageUrl, required this.title, required this.expireAt, required this.isUsed,super.key});

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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ),
          Text("사용만료일: $expireAt"),
          Padding(padding: const EdgeInsets.all(12.0),
          child: isUsed ? 
            FilledButton.tonal(onPressed: () {}, child: const Text('사용완료')) : 
            FilledButton(onPressed: () {}, child: const Text('사용가능')),
          )
        ],
      ),
    );
  }
}
