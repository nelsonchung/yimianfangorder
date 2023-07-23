import 'package:flutter/material.dart';

class BossModeScreen extends StatefulWidget {
  const BossModeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BossModeScreenState createState() => _BossModeScreenState();
}

class _BossModeScreenState extends State<BossModeScreen> {
  List<MenuCategory> menuCategories = [
    MenuCategory(
      title: '蒜香系列',
      items: [
        MenuItem(name: '蒜香辣味雞肉', imagePath: 'assets/蒜香辣味雞肉.jpeg'),
        MenuItem(name: '蒜香白酒蛤蠣', imagePath: 'assets/蒜香白酒蛤蠣.jpeg'),
        MenuItem(name: '蒜香辣味海鮮', imagePath: 'assets/蒜香辣味海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '奶油白醬系列',
      items: [
        MenuItem(name: '奶油培根', imagePath: 'assets/奶油培根.jpeg'),
        MenuItem(name: '奶油燻雞', imagePath: 'assets/奶油燻雞.jpeg'),
        MenuItem(name: '奶油蛤蠣', imagePath: 'assets/奶油蛤蠣.jpeg'),
        MenuItem(name: '奶油海鮮', imagePath: 'assets/奶油海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '青醬系列',
      items: [
        MenuItem(name: '青醬梅花豬', imagePath: 'assets/青醬梅花豬.jpeg'),
        MenuItem(name: '青醬雞肉', imagePath: 'assets/青醬雞肉.jpeg'),
        MenuItem(name: '青醬德腸', imagePath: 'assets/青醬德腸.jpeg'),
        MenuItem(name: '青醬海鮮', imagePath: 'assets/青醬海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '蕃茄紅醬系列',
      items: [
        MenuItem(name: '辣味番茄雞肉', imagePath: 'assets/辣味番茄雞肉.jpeg'),
        MenuItem(name: '西西里肉醬', imagePath: 'assets/西西里肉醬.jpeg'),
        MenuItem(name: '蕃茄海鮮', imagePath: 'assets/蕃茄海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '泰式香辣系列',
      items: [
        MenuItem(name: '泰式香辣雞肉', imagePath: 'assets/泰式香辣雞肉.jpeg'),
        MenuItem(name: '泰式香辣德腸', imagePath: 'assets/泰式香辣德腸.jpeg'),
        MenuItem(name: '泰式香辣蛤蠣', imagePath: 'assets/泰式香辣蛤蠣.jpeg'),
        MenuItem(name: '泰式香辣海鮮', imagePath: 'assets/泰式香辣海鮮.jpeg'),
      ],
    ),
  ];

  // 用於顯示當前選擇的座位和菜單
  // ...

  // 用於計算收入
  // ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('老闆模式'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 菜單
            const Text(
              '菜單',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuCategories.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menuCategories[index].title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: menuCategories[index].items.map((item) {
                          return Card(
                            child: ListTile(
                              title: Text(item.name),
                              leading: Image.asset(item.imagePath),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
            // ...
          ],
        ),
      ),
    );
  }
}

class MenuCategory {
  final String title;
  final List<MenuItem> items;

  MenuCategory({
    required this.title,
    required this.items,
  });
}

class MenuItem {
  final String name;
  final String imagePath;

  MenuItem({
    required this.name,
    required this.imagePath,
  });
}
