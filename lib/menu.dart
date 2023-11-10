
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
  int price = 0;
  int quantity = 0; // 初始化數量為0
  Map<String, bool> checkboxStates = {
    '直麵': false,
    '管麵': false,
    '燉飯': false,
  };
  DateTime? orderTime; // 新增這一行

  MenuItem({
    required this.name,
    required this.imagePath,
    this.quantity = 0,
    this.price = 0,
  });
}

final  List<MenuCategory> menuCategoriesData = [
    MenuCategory(
      title: '蒜香系列',
      items: [
        MenuItem(name: '蒜香辣味雞肉', price: 180, imagePath: 'assets/蒜香辣味雞肉.jpeg'),
        MenuItem(name: '蒜香白酒蛤蠣', price: 190, imagePath: 'assets/蒜香白酒蛤蠣.jpeg'),
        MenuItem(name: '蒜香辣味海鮮', price: 200, imagePath: 'assets/蒜香辣味海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '蕃茄紅醬系列',
      items: [
        MenuItem(name: '辣味番茄雞肉', price: 180, imagePath: 'assets/辣味番茄雞肉.jpeg'),
        MenuItem(name: '西西里肉醬', price: 190, imagePath: 'assets/西西里肉醬.jpeg'),
        MenuItem(name: '紅茄海鮮', price: 200, imagePath: 'assets/紅茄海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '奶油白醬系列',
      items: [
        MenuItem(name: '奶油培根', price: 180, imagePath: 'assets/奶油培根.jpeg'),
        MenuItem(name: '奶油燻雞', price: 180, imagePath: 'assets/奶油燻雞.jpeg'),
        MenuItem(name: '奶油蛤蠣', price: 190, imagePath: 'assets/奶油蛤蠣.jpeg'),
        MenuItem(name: '奶油海鮮', price: 200, imagePath: 'assets/奶油海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '青醬系列',
      items: [
        MenuItem(name: '青醬梅花豬', price: 180, imagePath: 'assets/青醬梅花豬.jpeg'),
        MenuItem(name: '青醬德腸', price: 180, imagePath: 'assets/青醬德腸.jpeg'),
        MenuItem(name: '青醬海鮮', price: 200, imagePath: 'assets/青醬海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '泰式香辣系列',
      items: [
        MenuItem(name: '泰式香辣雞肉', price: 180, imagePath: 'assets/泰式香辣雞肉.jpeg'),
        MenuItem(name: '泰式香辣德腸', price: 180, imagePath: 'assets/泰式香辣德腸.jpeg'),
        MenuItem(name: '泰式香辣蛤蠣', price: 190, imagePath: 'assets/泰式香辣蛤蠣.jpeg'),
        MenuItem(name: '泰式香辣海鮮', price: 200, imagePath: 'assets/泰式香辣海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '素食系列',
      items: [
        MenuItem(name: '奶油田園錦蔬', price: 180, imagePath: 'assets/奶油田園錦蔬.jpeg'),
        MenuItem(name: '印度咖哩錦蔬', price: 180, imagePath: 'assets/印度咖哩錦蔬.jpeg'),
        MenuItem(name: '南瓜田園錦蔬', price: 200, imagePath: 'assets/南瓜田園錦蔬.jpeg'),
      ],
    ),
    MenuCategory(
      title: '隱藏菜單',
      items: [
        MenuItem(name: '印度咖哩肉醬', price: 180, imagePath: 'assets/印度咖哩肉醬.jpeg'),
        MenuItem(name: '印泰雙降海鮮', price: 220, imagePath: 'assets/印泰雙降海鮮.jpeg'),
        MenuItem(name: '香濃南瓜雞肉', price: 200, imagePath: 'assets/香濃南瓜雞肉.jpeg'),
        MenuItem(name: '香濃南瓜海鮮', price: 220, imagePath: 'assets/香濃南瓜海鮮.jpeg'),
      ],
    ),
    MenuCategory(
      title: '香濃起司分享系列(可兩人分享)',
      items: [
        MenuItem(
            name: '香濃起司肉多多分享鍋(雞肉/德腸/培根/起司)',
            price: 380,
            imagePath: 'assets/香濃起司肉多多分享鍋.jpeg'),
        MenuItem(
            name: '香濃起司海陸分享鍋(雞肉/德腸/培根/起司)', 
            price: 430,
            imagePath: 'assets/香濃起司海陸分享鍋.jpeg'),
      ],
    ),
    MenuCategory(
      title: '焗烤系列',
      items: [
        MenuItem(name: '焗烤紅茄肉醬', price: 240, imagePath: 'assets/焗烤紅茄肉醬.jpeg'),
        MenuItem(name: '焗烤奶油燻雞', price: 240, imagePath: 'assets/焗烤奶油燻雞.jpeg'),
        MenuItem(name: '焗烤南瓜培根', price: 250, imagePath: 'assets/焗烤南瓜培根.jpeg'),
        MenuItem(name: '焗烤紅茄海鮮', price: 260, imagePath: 'assets/焗烤紅茄海鮮.jpeg'),
        MenuItem(name: '焗烤奶油海鮮', price: 260, imagePath: 'assets/焗烤奶油海鮮.jpeg'),
        MenuItem(name: '焗烤青醬海鮮', price: 260, imagePath: 'assets/焗烤奶油海鮮.jpeg'),
      ],
    ),
  ];

final  List<MenuCategory> menuCategoriesMiscellaneousData = [
    MenuCategory(
      title: '輕食/軟法沙拉盤',
      items: [
        MenuItem(name: '田園沙拉佐柚子油醋醬', price: 80, imagePath: 'assets/田園沙拉佐柚子油醋醬.jpeg'),
        MenuItem(name: '焗肉醬軟法麵包', price: 120, imagePath: 'assets/焗肉醬軟法麵包.jpeg'),
        MenuItem(name: '焗蕃茄肉醬軟法沙拉盤', price: 280, imagePath: 'assets/焗蕃茄肉醬軟法沙拉盤.jpeg'),
      ],
    ),
    MenuCategory(
      title: '升級套餐',
      items: [
        MenuItem(name: '主廚濃湯 + 蒜香軟法', price: 80, imagePath: 'assets/主廚濃湯_蒜香軟法.jpeg'),
        MenuItem(name: '主廚濃湯 + 蒜香軟法 + 飲料', price: 130, imagePath: 'assets/主廚濃湯_蒜香軟法_飲料.jpeg'),
      ],
    ),
    MenuCategory(
      title: '單點/飲料',
      items: [
        MenuItem(name: '主廚濃湯', price: 50, imagePath: 'assets/主廚濃湯.jpeg'),
        MenuItem(name: '蒜香軟法', price: 50, imagePath: 'assets/蒜香軟法.jpeg'),
        MenuItem(name: '紅茶(冰/熱)', price: 60, imagePath: 'assets/紅茶.jpeg'),
        MenuItem(name: '咖啡(冰/熱)', price: 60, imagePath: 'assets/咖啡.jpeg'),
        MenuItem(name: '柳橙汁', price: 50, imagePath: 'assets/柳橙汁.jpeg'),
        MenuItem(name: '可樂', price: 50, imagePath: 'assets/可樂.jpeg'),
        MenuItem(name: '雪碧', price: 50, imagePath: 'assets/雪碧.jpeg'),
      ],
    ),
  ];
   

