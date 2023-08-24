/*
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Nelson Chung
 * Creation Date: August 10, 2023
 */
 
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math'; 
import 'dart:io';
import 'dart:convert'; // 導入json解碼器
import 'menu.dart';

class DatabaseHelper {
  static final _dbName = 'orders.db';
  static final _dbVersion = 1;
  static final _tableName = 'orders';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnQuantity = 'quantity';
  static final columnOptions = 'selectedOptions';
  static final columnTime = 'orderTime';
  static final columnUserId = 'customernameid';
  static final columnPrice = 'price';

  // 使此類為單例
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
    _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path,
        version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnQuantity INTEGER NOT NULL,
            $columnOptions TEXT NOT NULL,
            $columnTime TEXT NOT NULL,
            $columnUserId TEXT NOT NULL,
            $columnPrice INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }  
}

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({Key? key}) : super(key: key);


  @override
  // ignore: library_private_types_in_public_api
  _CustomerOrderScreenState createState() => _CustomerOrderScreenState();
}



class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  //List<Map<String, dynamic>> orderedItems = []; // 儲存所有點餐資訊的列表
  List<MenuCategory> menuCategories = [];
  List<MenuCategory> menuCategoriesMiscellaneous = [];
  // 當前選擇的菜單
  Map<String, bool> selectedMenu = {}; // 使用Map記錄菜單的選擇狀態

  @override
  void initState() {
    super.initState();

    // 使用 menu.dart 中的資料進行初始化
    menuCategories = menuCategoriesData;
    menuCategoriesMiscellaneous = menuCategoriesMiscellaneousData;

    // 初始化 selectedMenu map
    for (var category in menuCategories) {
      for (var item in category.items) {
        selectedMenu[item.name] = false;
      }
    }
    for (var category in menuCategoriesMiscellaneous) {
      for (var item in category.items) {
        selectedMenu[item.name] = false;
      }
    }
  }

  String generateRandomUserId() {
  // 產生一個8位數的隨機數字作為使用者名稱
    final random = Random();
    int userId = random.nextInt(100000000); // 產生0到99999999之間的隨機數字
    return userId.toString().padLeft(8, '0'); // 補足到8位數，不足的部分補0
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
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
                      itemCount: menuCategories.length + menuCategoriesMiscellaneous.length,
                      itemBuilder: (context, index) {
                        MenuCategory currentCategory;
                        bool isMiscellaneous = false;

                        if (index < menuCategories.length) {
                          currentCategory = menuCategories[index];
                        } else {
                          currentCategory = menuCategoriesMiscellaneous[index - menuCategories.length];
                          isMiscellaneous = true;
                        }

                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentCategory.title,
                                style: const TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold
                                ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              children: currentCategory.items.map((item) {
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
                                        // 餐點名稱
                                        Text(
                                          item.name,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(width: 16),
                                        // 價錢
                                        Text(
                                          '\$${item.price.toString()}',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        if (!isMiscellaneous) ...[
                                          Checkbox(
                                            value: item.checkboxStates['直麵'], // 使用Map來獲取選擇狀態
                                            onChanged: (value) {
                                              // 修改選擇狀態並更新UI
                                              setState(() {
                                                item.checkboxStates['直麵'] = value ?? false;
                                              });
                                            },
                                          ),
                                          const Text('直麵'),
                                          Checkbox(
                                            value: item.checkboxStates['管麵'], // 使用Map來獲取選擇狀態
                                            onChanged: (value) {
                                              // 修改選擇狀態並更新UI
                                              setState(() {
                                                item.checkboxStates['管麵'] = value ?? false;
                                              });
                                            },
                                          ),
                                          const Text('管麵'),
                                          Checkbox(
                                            value: item.checkboxStates['燉飯'], // 使用Map來獲取選擇狀態
                                            onChanged: (value) {
                                              // 修改選擇狀態並更新UI
                                              setState(() {
                                                item.checkboxStates['燉飯'] = value ?? false;
                                              });
                                            },
                                          ),
                                          const Text('燉飯'),
                                        ],
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
                          ),
                        );
                      },
                    ),
                  ),
                  // 點餐確認按鈕
                  ElevatedButton(
                    onPressed: () async {
                      DateTime now = DateTime.now(); // 獲取當前時間
                      
                      // 產生隨機的使用者名稱 (customernameid)
                      String customernameid = generateRandomUserId();

                      // 把兩個菜單列表結合在一起，方便迭代
                      List<MenuCategory> combinedMenuCategories = menuCategories + menuCategoriesMiscellaneous;

                      // 將點餐資料存儲到 orderedItems 中
                      List<Map<String, dynamic>> orderedItemsData = [];
                     
                      for (MenuCategory category in combinedMenuCategories) {
                        for (MenuItem item in category.items) {
                          if (item.quantity > 0) {
                            item.orderTime = now; // 設置訂單時間
                            Map<String, dynamic> orderedItem = {
                              'name': item.name,
                              'quantity': item.quantity,
                              'selectedOptions': jsonEncode(item.checkboxStates), // 將選擇狀態轉換為JSON字符串
                              'orderTime': item.orderTime?.toIso8601String(), // 將時間轉換為ISO 8601格式的字符串
                              'customernameid': customernameid, // 將使用者名稱新增到點餐資料
                              'price': item.price, //價錢
                            };
                            orderedItemsData.add(orderedItem); // 將新的點餐資訊添加到 orderedItems 列表中
                            print("訂單資訊：${orderedItem.toString()}");  // 列印出訂餐資訊
                          }
                        }
                      }

                      DatabaseHelper helper = DatabaseHelper.instance;

                      for (var item in orderedItemsData) {
                        int id = await helper.insert(item);
                        print('inserted row id: $id');
                      }

                      // 重置點餐資料
                      setState(() {
                        for (MenuCategory category in combinedMenuCategories) {
                          for (MenuItem item in category.items) {
                            item.quantity = 0;
                            item.checkboxStates = {
                              '直麵': false,
                              '管麵': false,
                              '燉飯': false,
                            };
                          }
                        }
                      });

                      // 顯示SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('店家已收到你的訂餐資訊'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // 返回到main.dart
                      // 返回到 HomeScreen
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(182, 30, 144, 10),
                    ),
                    child: const Text('點餐確認，送出'),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 134, 187, 149),
      ),
    );
  }
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
