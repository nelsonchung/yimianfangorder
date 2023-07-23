import 'package:flutter/material.dart';

class CustomerOrderScreen extends StatelessWidget {
  const CustomerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('顧客模式'),
      ),
      body: const Center(
        child: Text(
          '這是顧客模式頁面',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
