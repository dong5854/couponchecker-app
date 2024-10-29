import 'package:cloud_firestore/cloud_firestore.dart';

class Coupon {
  final String id;
  final String name;
  final String imageUrl;
  final String expireAt;
  final bool used;

  Coupon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.expireAt,
    required this.used,
  });

  factory Coupon.fromDocument(DocumentSnapshot doc) {
    return Coupon(
      id : doc.id,
      name: doc['name'],
      imageUrl: doc['image_url'],
      expireAt: doc['expire_at'],
      used: doc['used'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name" : name,
      "image_url" : imageUrl,
      "expire_at" : expireAt,
      "used" : used
    };
  } 
}
