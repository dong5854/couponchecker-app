import 'package:couponchecker/data/coupon_repository.dart';
import 'package:couponchecker/model/coupon.dart';
import 'package:couponchecker/util/formatter.dart';
import 'package:flutter/material.dart';

class CouponCard extends StatefulWidget {
  final CouponRepository couponRepository;
  final Coupon coupon;

  const CouponCard({required this.couponRepository, required this.coupon, super.key});

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  late Coupon coupon;

  @override
  void initState() {
    super.initState();
    coupon = widget.coupon;
  }

  void toggleUsage() {
    widget.couponRepository.updateCoupons(coupon = Coupon(
      id: widget.coupon.id,
      name: widget.coupon.name,
      imageUrl: widget.coupon.imageUrl,
      expireAt: widget.coupon.expireAt,
      used: !widget.coupon.used,
    ));
    setState(() {});
  }

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
          SizedBox(
            width: 1000, // 최대 가로 크기
            height: 300, // 최대 세로 크기
            child: ClipRect(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.coupon.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Center(child: Icon(Icons.error, color: Colors.red));
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.coupon.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Text("사용만료일: ${formatDate(widget.coupon.expireAt)}"),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: coupon.used
                ? FilledButton.tonal(onPressed: () { toggleUsage(); }, child: const Text('사용완료'))
                : FilledButton(onPressed: () { toggleUsage(); }, child: const Text('사용가능')),
          ),
        ],
      ),
    );
  }
}
