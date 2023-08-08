import 'package:flutter/material.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomerOrderScreenState createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
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
      title: '蕃茄紅醬系列',
      items: [
        MenuItem(name: '辣味番茄雞肉', imagePath: 'assets/辣味番茄雞肉.jpeg'),
        MenuItem(name: '西西里肉醬', imagePath: 'assets/西西里肉醬.jpeg'),
        MenuItem(name: '紅茄海鮮', imagePath: 'assets/紅茄海鮮.jpeg'),
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
        MenuItem(name: '青醬德腸', imagePath: 'assets/青醬德腸.jpeg'),
        MenuItem(name: '青醬海鮮', imagePath: 'assets/青醬海鮮.jpeg'),
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
    MenuCategory(
      title: '素食系列',
      items: [
        MenuItem(name: '奶油田園錦蔬', imagePath: 'assets/奶油田園錦蔬.jpeg'),
        MenuItem(name: '印度咖哩錦蔬', imagePath: 'assets/印度咖哩錦蔬.jpeg'),
        MenuItem(name: '南瓜田園錦蔬', imagePath: 'assets/南瓜田園錦蔬.jpeg'),
      ],
    ),
    MenuCategory(
      title: '隱藏菜單',
      items: [
        MenuItem(name: '印度咖哩肉醬', imagePath: 'assets/印度咖哩肉醬.jpeg'),
        MenuItem(name: '印泰雙降海鮮', imagePath: 'assets/印泰雙降海鮮.jpeg'),
        MenuItem(name: '香濃南瓜雞肉', imagePath: 'assets/香濃南瓜雞肉.jpeg'),
        MenuItem(name: '香濃南瓜海鮮', imagePath: 'assets/香濃南瓜海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '香濃起司分享系列(可兩人分享)',
      items: [
        MenuItem(
            name: '香濃起司肉多多分享鍋(雞肉/德腸/培根/起司)',
            imagePath: 'assets/香濃起司肉多多分享鍋.jpeg'),
        MenuItem(
            name: '香濃起司海陸分享鍋(雞肉/德腸/培根/起司)', imagePath: 'assets/香濃起司海陸分享鍋.jpeg'),
      ],
    ),
    MenuCategory(
      title: '焗烤系列',
      items: [
        MenuItem(name: '焗烤紅茄肉醬', imagePath: 'assets/焗烤紅茄肉醬.jpeg'),
        MenuItem(name: '焗烤奶油燻雞', imagePath: 'assets/焗烤奶油燻雞.jpeg'),
        MenuItem(name: '焗烤南瓜培根', imagePath: 'assets/焗烤南瓜培根.jpeg'),
        MenuItem(name: '焗烤紅茄海鮮', imagePath: 'assets/焗烤紅茄海鮮.jpeg'),
        MenuItem(name: '焗烤奶油海鮮', imagePath: 'assets/焗烤奶油海鮮.jpeg'),
        MenuItem(name: '焗烤青醬海鮮', imagePath: 'assets/焗烤奶油海鮮.jpeg'),
      ],
    ),
  ];

  List<MenuCategory> menuCategoriesMiscellaneous = [
    MenuCategory(
      title: '輕食/軟法沙拉盤',
      items: [
        MenuItem(name: '田園沙拉佐柚子油醋醬', imagePath: 'assets/焗烤紅茄肉醬.jpeg'),
        MenuItem(name: '焗肉醬軟法麵包', imagePath: 'assets/焗烤奶油燻雞.jpeg'),
        MenuItem(name: '焗蕃茄肉醬軟法沙拉盤', imagePath: 'assets/焗烤南瓜培根.jpeg'),
      ],
    ),
    MenuCategory(
      title: '升級套餐',
      items: [
        MenuItem(name: '主廚濃湯 + 蒜香軟法', imagePath: 'assets/焗烤紅茄肉醬.jpeg'),
        MenuItem(name: '主廚濃湯 + 蒜香軟法 + 飲料', imagePath: 'assets/焗烤奶油燻雞.jpeg'),
      ],
    ),
    MenuCategory(
      title: '單點/飲料',
      items: [
        MenuItem(name: '主廚濃湯', imagePath: 'assets/焗烤紅茄肉醬.jpeg'),
        MenuItem(name: '蒜香軟法', imagePath: 'assets/焗烤奶油燻雞.jpeg'),
        MenuItem(name: '紅茶(冰/熱)', imagePath: 'assets/焗烤南瓜培根.jpeg'),
        MenuItem(name: '咖啡(冰/熱)', imagePath: 'assets/焗烤南瓜培根.jpeg'),
        MenuItem(name: '柳橙汁', imagePath: 'assets/焗烤南瓜培根.jpeg'),
        MenuItem(name: '可樂', imagePath: 'assets/焗烤南瓜培根.jpeg'),
        MenuItem(name: '雪」、」、', imagePath: 'assets/焗烤南瓜培根.jpeg'),
      ],
    ),
  ]

  // 用於顯示當前選擇的座位和菜單
  // ...

  // 用於計算收入
  // ...

  // 當前選擇的菜單
  Map<String, bool> selectedMenu = {}; // 使用Map記錄菜單的選擇狀態

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('顧客模式'),
          backgroundColor: const Color(0xFF61B378),
          bottom: const TabBar(
            tabs: [
              Tab(text: '菜單'),
              //Tab(text: '日結'),
              //Tab(text: '月結'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 第一個Tab頁面，顯示菜單
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 座位分配圖
                  const Text(
                    '座位分配圖',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // ... (之前的座位卡片部分相同)

                  const SizedBox(height: 20),
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
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // 圖片
                                        Image.asset(
                                          item.imagePath,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 16),
                                        // 菜色名字
                                        Text(
                                          item.name,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // 設計三個checkbox，名稱為 直麵，管麵，燉飯
                                        Checkbox(
                                          value: false, // 替換成相應的值
                                          onChanged: (value) {
                                            // checkbox的邏輯
                                            // ...
                                          },
                                        ),
                                        const Text('直麵'),
                                        Checkbox(
                                          value: false, // 替換成相應的值
                                          onChanged: (value) {
                                            // checkbox的邏輯
                                            // ...
                                          },
                                        ),
                                        const Text('管麵'),
                                        Checkbox(
                                          value: false, // 替換成相應的值
                                          onChanged: (value) {
                                            // checkbox的邏輯
                                            // ...
                                          },
                                        ),
                                        const Text('燉飯'),
                                        const Spacer(),
                                        // 減號 icon
                                        IconButton(
                                          onPressed: () {
                                            // 減號按鈕的邏輯
                                            setState(() {
                                              if (item.quantity > 0) {
                                                item.quantity--;
                                              }
                                            });
                                          },
                                          icon: const Icon(Icons.remove),
                                        ),
                                        // 數字
                                        Text('${item.quantity}'),
                                        // 加號 icon
                                        IconButton(
                                          onPressed: () {
                                            // 加號按鈕的邏輯
                                            setState(() {
                                              if (item.quantity < 99) {
                                                item.quantity++;
                                              }
                                            });
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                    // 備註欄位
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: '備註',
                                      ),
                                      onChanged: (value) {
                                        // 備註欄位的邏輯
                                        // ...
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                    ),
                  ),
                  // 點餐確認按鈕
                  ElevatedButton(
                    onPressed: () {
                      // 點餐確認按鈕的邏輯
                      // ...
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(182, 30, 144, 10),
                    ),
                    child: const Text('點餐確認，送出'),
                  ),
                ],
              ),
            ),
            // 第二個Tab頁面，顯示日結功能
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 日結按鈕的邏輯
                  // ...
                },
                child: const Text('日結'),
              ),
            ),
            // 第三個Tab頁面，顯示月結功能
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 月結按鈕的邏輯
                  // ...
                },
                child: const Text('月結'),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 134, 187, 149),
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
  int quantity; // 菜單數量

  MenuItem({
    required this.name,
    required this.imagePath,
    this.quantity = 0, // 預設數量為0
  });
}

class SeatCard extends StatelessWidget {
  final String seatNumber;
  final int capacity;

  const SeatCard({Key? key, required this.seatNumber, required this.capacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '座位 $seatNumber',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('$capacity 人'),
          ],
        ),
      ),
    );
  }
}
