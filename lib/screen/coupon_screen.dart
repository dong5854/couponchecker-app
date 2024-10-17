import 'package:flutter/material.dart';

class CouponCheckerAppBar extends StatelessWidget {
  const CouponCheckerAppBar({super.key});

  @override
  Widget build(BuildContext context) {

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 3;

    final List<Map<String, String>> items = [
  {
    'imageUrl': 'https://images.pokemoncard.io/images/cel25/cel25-7.png',
    'title': '날으는 돼지카츄',
  },
  {
    'imageUrl': 'https://images.pokemoncard.io/images/base2/base2-60.png',
    'title': '근본 뚱카츄',
  },
  {
    'imageUrl': 'https://images.pokemoncard.io/images/xyp/xyp-XY202.png',
    'title': '근본 뚱카츄 폴짝',
  },
  {
    'imageUrl': 'https://images.pokemoncard.io/images/basep/basep-1.png',
    'title': '90년대 3d 게임 뚱카츄',
  },
];


    final List<String> titles = <String>[
      '사용가능',
      '사용완료',
      '업로드',
    ];

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('쿠폰함'),
          // This check specifies which nested Scrollable's scroll notification
          // should be listened to.
          //
          // When `ThemeData.useMaterial3` is true and scroll view has
          // scrolled underneath the app bar, this updates the app bar
          // background color and elevation.
          //
          // This sets `notification.depth == 1` to listen to the scroll
          // notification from the nested `ListView.builder`.
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
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
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 25,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(
                        items[index%4]['imageUrl']!,
                        fit: BoxFit.fill,
                        ),
                        Text(items[index%4]['title']!), // 각 항목의 제목
                        ],
                        ),
                          );
  },
),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(items[0]['imageUrl']!),
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[1]} $index'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[2]} $index'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}