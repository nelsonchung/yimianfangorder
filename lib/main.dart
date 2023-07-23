import 'package:flutter/material.dart';
import 'customer_order.dart';
import 'boss_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My iPad App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('義麵房'),
        backgroundColor: const Color(0xFF3FC979),
      ),
      body: Container(
        color: const Color(0xFF3FC979), // 背景顏色
        /*
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'), // 背景圖片
            fit: BoxFit.cover,
          ),
        ),
        */
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerOrderScreen()),
                  );
                },
                child: const Text('顧客模式'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BossModeScreen()),
                  );
                },
                child: const Text('老闆模式'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
