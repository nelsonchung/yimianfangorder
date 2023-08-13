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
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BossModeScreen extends StatefulWidget {
  const BossModeScreen({Key? key}) : super(key: key);

  @override
  _BossModeScreenState createState() => _BossModeScreenState();
}

class _BossModeScreenState extends State<BossModeScreen> {
  List<Map<String, dynamic>> orderedItems = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadOrderedItems();
  }

  Future<void> loadOrderedItems() async {
    prefs = await SharedPreferences.getInstance();  // 初始化 prefs
    String? orderedItemsJson = prefs.getString('orderedItems');
    if (orderedItemsJson != null) {
      setState(() {
        orderedItems = List<Map<String, dynamic>>.from(jsonDecode(orderedItemsJson));
      });
    } else {
      orderedItems = []; // 如果沒有任何資料，則初始化為空列表
     }

    //print debug message
    print('讀取的點餐資訊: $orderedItemsJson');
  }

  double calculateTotalAmountForCustomer(String customernameid) {
    double totalAmount = 0;
    for (Map<String, dynamic> item in orderedItems) {
      if (item['customernameid'] == customernameid) {
        totalAmount += (item['price'] * item['quantity']);
      }
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('老闆模式'),
          backgroundColor: const Color(0xFF61B378),
          bottom: const TabBar(
            tabs: [
              Tab(text: '點餐資訊'),
              Tab(text: '日結'),
              Tab(text: '月結'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 第一個Tab頁面，顯示顧客點的點餐資訊
            ListView.builder(
              itemCount: orderedItems.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> orderedItem = orderedItems[index];
                DateTime orderDateTime = DateTime.parse(orderedItem['orderTime']);
                bool isToday = orderDateTime.year == DateTime.now().year &&
                    orderDateTime.month == DateTime.now().month &&
                    orderDateTime.day == DateTime.now().day;

                return isToday
                ? SingleChildScrollView(
                  child: Column(
                    //? Column(
                        children: [
                          ListTile(
                            title: Text(orderedItem['name']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(orderedItem['customernameid']),
                                Text('數量: ${orderedItem['quantity']}'),
                                Text('訂餐時間: ${orderedItem['orderTime']}'), // 顯示訂餐時間
                                Text('價位: ${orderedItem['price']}'),
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: orderedItem['selectedOptions'].entries
                                  .where((entry) => entry.value == true)
                                  .map<Widget>((entry) {
                                    return Text('${entry.key}: 是');
                                  }).toList(),
                            ),
                          ),
                          if (index == orderedItems.length - 1)
                            Text(
                              '總金額：${calculateTotalAmountForCustomer(orderedItem['customernameid'])}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                    )
                    : SizedBox();
              },
            ),
            // 第二個Tab頁面，顯示日結功能
            ListView.builder(
              itemCount: orderedItems.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> orderedItem = orderedItems[index];
                DateTime orderDateTime = DateTime.parse(orderedItem['orderTime']);

                // 篩選符合日結條件的點餐資訊（年、月、日相符）
                if (orderDateTime.year == DateTime.now().year &&
                    orderDateTime.month == DateTime.now().month &&
                    orderDateTime.day == DateTime.now().day) {
                  return ListTile(
                    title: Text(orderedItem['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('數量: ${orderedItem['quantity']}'),
                        Text('訂餐時間: ${orderedItem['orderTime']}'),
                        Text('使用者名稱: ${orderedItem['customernameid']}'), // 顯示使用者名稱
                        Text('價位: ${orderedItem['price']}'),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: orderedItem['selectedOptions'].entries
                          .where((entry) => entry.value == true)
                          .map<Widget>((entry) {
                            return Text('${entry.key}: 是');
                          }).toList(),
                    ),
                  );
                } else {
                  return Container(); // 不顯示不符合日結條件的點餐資訊
                }
              },
            ),
            // 第三個Tab頁面，顯示月結功能
            ListView.builder(
              itemCount: orderedItems.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> orderedItem = orderedItems[index];
                DateTime orderDateTime = DateTime.parse(orderedItem['orderTime']);

                // 篩選符合日結條件的點餐資訊（年、月相符）
                if (orderDateTime.year == DateTime.now().year &&
                    orderDateTime.month == DateTime.now().month) {
                  return ListTile(
                    title: Text(orderedItem['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('數量: ${orderedItem['quantity']}'),
                        Text('訂餐時間: ${orderedItem['orderTime']}'),
                        Text('使用者名稱: ${orderedItem['customernameid']}'), // 顯示使用者名稱
                        Text('價位: ${orderedItem['price']}'),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: orderedItem['selectedOptions'].entries
                          .where((entry) => entry.value == true)
                          .map<Widget>((entry) {
                            return Text('${entry.key}: 是');
                          }).toList(),
                    ),
                  );
                } else {
                  return Container(); // 不顯示不符合日結條件的點餐資訊
                }
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 134, 187, 149),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BossModeScreen(),
  ));
}
