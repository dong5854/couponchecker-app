import 'package:couponchecker/widget/coupon_card.dart';
import 'package:couponchecker/widget/image_dialog.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

class CouponListView extends StatefulWidget {
  const CouponListView({super.key});

  @override
  State<CouponListView> createState() => _CouponListViewState();
}

class _CouponListViewState extends State<CouponListView> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  
    Future<List<Map<String, dynamic>>> _fetchCoupons() async {
    final DataSnapshot snapshot = await ref.child("coupon").get();
    final List<Map<String, dynamic>> coupons = [];

    if (snapshot.exists) {
      Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;

      data?.forEach((key, value) {
        coupons.add({
          'name': value['name'],
          'image_url': value['image_url'],
        });
      });
    }
    return coupons;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchCoupons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No coupons available.'));
        }

        final coupons = snapshot.data!;

        return ListView.builder(
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            final coupon = coupons[index];

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ImageDialog(imageUrl: coupon['image_url']!);
                  },
                );
              },
              child: CouponCard(
                imageUrl: coupon['image_url']!,
                title: coupon['name']!,
              ),
            );
          },
        );
      },
    );
  }
}
