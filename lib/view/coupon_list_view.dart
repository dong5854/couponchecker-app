import 'package:couponchecker/data/coupon_repository.dart';
import 'package:couponchecker/model/coupon.dart';
import 'package:couponchecker/widget/coupon_card.dart';
import 'package:couponchecker/widget/image_dialog.dart';
import 'package:flutter/material.dart';

class CouponListView extends StatefulWidget {
  final bool viewUsed;
  final CouponRepository couponRepository;

    const CouponListView({required this.viewUsed, required this.couponRepository, super.key});

  @override
  State<CouponListView> createState() => _CouponListViewState();
}

class _CouponListViewState extends State<CouponListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Coupon>>(
      future: widget.couponRepository.fetchCoupons(widget.viewUsed),
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
                    return ImageDialog(imageUrl: coupon.imageUrl);
                  },
                );
              },
              child: CouponCard(couponRepository: widget.couponRepository, coupon: coupon),
            );
          },
        );
      },
    );
  }
}
