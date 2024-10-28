import 'package:couponchecker/view/coupon_list_view.dart';
import 'package:couponchecker/view/used_coupon_list_view.dart';
import 'package:couponchecker/widget/app_bar.dart';
import 'package:couponchecker/view/coupon_uploader_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: const CouponCheckerAppBar(),
        body: TabBarView(
            children: <Widget>[
              CouponListView(viewUsed:false),
              CouponListView(viewUsed:true),
              CouponUploaderView(),
            ],
          ),
      ),
    );
  }
}
