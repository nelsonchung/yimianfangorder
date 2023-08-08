import 'package:flutter/material.dart';

class BossModeScreen extends StatelessWidget {
  const BossModeScreen({super.key});

  // 當前選擇的菜單
  //Map<String, bool> selectedMenu = {}; // 使用Map記錄菜單的選擇狀態

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
              Tab(text: '日結'),
              Tab(text: '月結'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 第一個Tab頁面，顯示菜單
            Center(
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