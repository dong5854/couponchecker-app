import 'package:flutter/material.dart';
class UsedCouponListView extends StatelessWidget {
  const UsedCouponListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {'imageUrl': 'https://images.pokemoncard.io/images/cel25/cel25-7.png', 'title': '날으는 뚱카츄'},
    ];

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ListView.builder(
      itemCount: 25,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.network(items[0]['imageUrl']!),
          tileColor: index.isOdd ? oddItemColor : evenItemColor,
          title: Text('사용완료 $index'),
        );
      },
    );
  }
}