import 'package:flutter/material.dart';

class CouponCheckerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CouponCheckerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> titles = ['사용가능', '사용완료', '업로드'];

    return AppBar(
      title: const Text('쿠폰함'),
      notificationPredicate: (ScrollNotification notification) {
        return notification.depth == 1;
      },
      scrolledUnderElevation: 4.0,
      shadowColor: Theme.of(context).shadowColor,
      bottom: TabBar(
        tabs: <Widget>[
          Tab(
            icon: const Icon(Icons.wallet),
            text: titles[0],
          ),
          Tab(
            icon: const Icon(Icons.check),
            text: titles[1],
          ),
          Tab(
            icon: const Icon(Icons.add_box_outlined),
            text: titles[2],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}