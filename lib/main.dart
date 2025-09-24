import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1️⃣ 主 Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 去掉右上角的 DEBUG 标志
      home: Scaffold(
        backgroundColor: Colors.lightBlue[100], // 🎨 改背景颜色
        appBar: AppBar(
          title: const Text("Day 1 - Hello Flutter"),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text(
            "Hello World 👋",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ),
    );
  }
}
