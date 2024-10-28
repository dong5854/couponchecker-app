import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couponchecker/util/formatter.dart';
import 'package:couponchecker/widget/coupon_card.dart';
import 'package:couponchecker/widget/image_dialog.dart';
import 'package:flutter/material.dart';

class CouponListView extends StatefulWidget {
  final bool viewUsed;

  const CouponListView({required this.viewUsed, super.key});

  @override
  State<CouponListView> createState() => _CouponListViewState();
}

class _CouponListViewState extends State<CouponListView> {
  final db = FirebaseFirestore.instance;
  
  Future<List<Map<String, dynamic>>> _fetchCoupons(bool used) async {
    final QuerySnapshot snapshot = await db.collection('coupon').where('used', isEqualTo: used).get();
    final List<Map<String, dynamic>> coupons = [];

    for (var doc in snapshot.docs) {
      coupons.add({
        'name': doc['name'],
        'image_url' : doc['image_url'],
        'expire_at' : doc['expire_at'],
        'used' : doc['used']
      });
    }

    return coupons;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchCoupons(widget.viewUsed),
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
                expireAt: formatDate(coupon['expire_at']!),
                isUsed: coupon['used'],
              ),
            );
          },
        );
      },
    );
  }
}
