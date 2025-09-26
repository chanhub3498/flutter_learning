import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("手机菜单界面")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "我的应用",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              // 第一行菜单
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  menuItem(Icons.home, "首页"),
                  menuItem(Icons.search, "搜索"),
                  menuItem(Icons.settings, "设置"),
                ],
              ),
              const SizedBox(height: 30),
              // 第二行菜单
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  menuItem(Icons.person, "我的"),
                  menuItem(Icons.message, "消息"),
                  menuItem(Icons.notifications, "通知"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 自定义菜单项 Widget
  Widget menuItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(icon, size: 36, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
