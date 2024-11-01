import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couponchecker/model/coupon.dart';

class CouponRepository {
  final db = FirebaseFirestore.instance;

  Future<List<Coupon>> fetchCoupons(bool used) async {
    final QuerySnapshot snapshot = await db.collection('coupon').orderBy('expire_at').where('used', isEqualTo: used).get();
    final List<Coupon> coupons = snapshot.docs.map((doc) => Coupon.fromDocument(doc)).toList();

    return coupons;
  }

  Future<void> updateCoupons(Coupon coupon) async {
    db.collection('coupon').doc(coupon.id).set(coupon.toMap());
  }

    Future<void> writeCoupon(Coupon coupon) async {
    await db.collection('coupon').add(coupon.toMap());
  }
}