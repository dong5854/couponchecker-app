import 'package:couponchecker/widget/coupon_card.dart';
import 'package:couponchecker/widget/image_dialog.dart';
import 'package:flutter/material.dart';

class CouponListView extends StatelessWidget {
  const CouponListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {'imageUrl': 'https://images.pokemoncard.io/images/cel25/cel25-7.png', 'title': '날으는 뚱카츄'},
      {'imageUrl': 'https://images.pokemoncard.io/images/base2/base2-60.png', 'title': '근본 뚱카츄'},
      {'imageUrl': 'https://images.pokemoncard.io/images/cel25/cel25-9.png', 'title': '서핑 뚱카츄'},
      {'imageUrl': 'https://images.pokemoncard.io/images/swsh4/swsh4-188.png', 'title': '무지개 뚱카츄'},
    ];

    return ListView.builder(
      itemCount: 25,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ImageDialog(imageUrl: items[index % 4]['imageUrl']!);
              },
            );
          },
          child: CouponCard(
            imageUrl: items[index % 4]['imageUrl']!,
            title: items[index % 4]['title']!,
          ),
        );
      },
    );
  }
}
