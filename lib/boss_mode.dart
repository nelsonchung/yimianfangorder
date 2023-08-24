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
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';


class BossModeScreen extends StatefulWidget {
  const BossModeScreen({Key? key}) : super(key: key);

  @override
  _BossModeScreenState createState() => _BossModeScreenState();
}

class _BossModeScreenState extends State<BossModeScreen> {
  late Future<Database> _db; // 定義數據庫變數
  List<Map<String, dynamic>> orderedItems = [];
  
  @override
  void initState() {
    super.initState();
    _initDb().then((_) {
      _loadOrders();
    });
  }

  Future<void> _initDb() async {
    var getpath = await getDatabasesPath();
    String dbpath = join(getpath, 'orders.db');
    
    _db = openDatabase(
      dbpath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE orders (id INTEGER PRIMARY KEY, " +
          "name TEXT, " +
          "quantity INTEGER, " +
          "selectedOptions TEXT, " +
          "orderTime TEXT, " +
          "customernameid TEXT, " +
          "price INTEGER)",
        );
      },
    );
  }

  Future<void> _loadOrders() async {
    final db = await _db;
    List<Map<String, dynamic>> orders = await db.query('orders');
    orderedItems = orders.map((order) {
      // Make a mutable copy of the order
      Map<String, dynamic> mutableOrder = Map.from(order);
      // Modify the mutable copy
      mutableOrder['selectedOptions'] = jsonDecode(order['selectedOptions']);
      return mutableOrder;
    }).toList();
    print('查詢到的訂單資訊: $orderedItems');
    setState(() {});
  }

  double totalAmountForCustomer(String customernameid) {
    double totalAmount = 0;
    for (Map<String, dynamic> item in orderedItems) {
      if (item['customernameid'] == customernameid) {
        totalAmount += (item['price'] * item['quantity']);
      }
    }
    return totalAmount;
  }

  double totalAmountForDay(DateTime day) {
    double totalAmount = 0;
    for (Map<String, dynamic> item in orderedItems) {
      DateTime orderDateTime = DateTime.parse(item['orderTime']);
      if (orderDateTime.year == day.year &&
          orderDateTime.month == day.month &&
          orderDateTime.day == day.day) {
        totalAmount += (item['price'] * item['quantity']);
      }
    }
    return totalAmount;
  }

  double totalAmountForMonth() {
    double totalAmount = 0;
    for (Map<String, dynamic> item in orderedItems) {
      totalAmount += (item['price'] * item['quantity']);
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

                bool isNewCustomer = index == 0 || orderedItems[index]['customernameid'] != orderedItems[index - 1]['customernameid'];

                return isToday
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            if (isNewCustomer && index != 0)
                              Divider(
                                thickness: 2,
                                color: Colors.black,
                              ),
                            ListTile(
                              title: Text(orderedItem['name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(orderedItem['customernameid']),
                                  Text('數量: ${orderedItem['quantity']}'),
                                  Text('訂餐時間: ${orderedItem['orderTime']}'), // 顯示訂餐時間
                                  Text('價位: ',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('${orderedItem['price']}',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
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
                          ],
                        ),
                      )
                    : SizedBox();
              },
            ),
            // 第二個Tab頁面，顯示日結功能
            Column(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    double totalAmountForToday = totalAmountForDay(DateTime.now());
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '今日總金額：$totalAmountForToday',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: orderedItems.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> orderedItem = orderedItems[index];
                      DateTime orderDateTime = DateTime.parse(orderedItem['orderTime']);
                      double totalAmount = totalAmountForCustomer(orderedItem['customernameid']);

                      bool isNewCustomer = index == 0 || orderedItems[index]['customernameid'] != orderedItems[index - 1]['customernameid'];            
                      
                      // 篩選符合日結條件的點餐資訊（年、月、日相符）
                      if (orderDateTime.year == DateTime.now().year &&
                          orderDateTime.month == DateTime.now().month &&
                          orderDateTime.day == DateTime.now().day) {
                            // 顯示同一個customernameid的總金額
                          // 只有當客戶的總金額尚未顯示時，才顯示該客戶的總金額
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  if (isNewCustomer && index != 0)
                                    Divider(
                                      thickness: 2,
                                      color: Colors.black,
                                    ),
                                  //if (isNewCustomer && index != 0)
                                  if (isNewCustomer || index == 0)
                                    Text('總金額：$totalAmount',style: TextStyle(fontWeight: FontWeight.bold)),

                                  ListTile(
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
                                  ),
                                  //Text('總金額：$totalAmount'),
                                ],
                              ),
                            );
                        } else {
                          return Container(); // 不顯示不符合日結條件的點餐資訊
                        }
                      },
                    ),
                  ),
              ],
            ),
            // 第三個Tab頁面，顯示月結功能
            Column(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    double totalamountformonth = totalAmountForMonth();
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '本月總金額：${totalamountformonth.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: orderedItems.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> orderedItem = orderedItems[index];
                      DateTime orderDateTime = DateTime.parse(orderedItem['orderTime']);
                      double totalAmount = totalAmountForDay(orderDateTime);

                      bool isNewDay = index == 0 || DateTime.parse(orderedItems[index]['orderTime']).day != DateTime.parse(orderedItems[index - 1]['orderTime']).day;

                      // 篩選符合月結條件的點餐資訊（年、月相符）
                      if (orderDateTime.year == DateTime.now().year &&
                          orderDateTime.month == DateTime.now().month) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              if (isNewDay && index != 0)
                                Divider(
                                  thickness: 2,
                                  color: Colors.black,
                                ),
                              if (isNewDay || index == 0)
                              //if (index == 0)
                                Text('當天總金額：${totalAmount.toStringAsFixed(2)}',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                              ListTile(
                                title: Text(orderedItem['name']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('數量: ${orderedItem['quantity']}'),
                                    Text('訂餐時間: ${orderedItem['orderTime']}'),
                                    Text('使用者名稱: ${orderedItem['customernameid']}'),
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
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
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
