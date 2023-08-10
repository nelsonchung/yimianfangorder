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

  @override
  void initState() {
    super.initState();
    loadOrderedItems();
  }

  Future<void> loadOrderedItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? orderedItemsJson = prefs.getString('orderedItems');
    if (orderedItemsJson != null) {
      setState(() {
        orderedItems = List<Map<String, dynamic>>.from(jsonDecode(orderedItemsJson));
      });
    }
    //print debug message
    print('讀取的點餐資訊: $orderedItemsJson');
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
                return ListTile(
                  title: Text(orderedItem['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('數量: ${orderedItem['quantity']}'),
                      Text('訂餐時間: ${orderedItem['orderTime']}'), // 顯示訂餐時間
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: orderedItem['selectedOptions'].entries
                        .where((entry) => entry.value == true) // 只顯示 "是" 的餐點
                        .map<Widget>((entry) {
                          return Text('${entry.key}: 是');
                        }).toList(),
                  ),
                );
              },
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

void main() {
  runApp(MaterialApp(
    home: BossModeScreen(),
  ));
}
