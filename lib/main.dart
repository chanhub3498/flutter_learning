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
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Column(
            children: [
              // 顶部标题
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "主界面布局",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),

              // 第一行菜单
              Row(
                children: [
                  Expanded(child: menuBox(Icons.home, "首页", Colors.blue)),
                  Expanded(child: menuBox(Icons.search, "搜索", Colors.green)),
                ],
              ),

              // 第二行菜单
              Row(
                children: [
                  Expanded(child: menuBox(Icons.person, "我的", Colors.orange)),
                  Expanded(child: menuBox(Icons.settings, "设置", Colors.purple)),
                ],
              ),

              // Spacer 撑开，把按钮挤到底部
              const Spacer(),

              // 底部按钮
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "立即开始",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 自定义菜单 Box
  static Widget menuBox(IconData icon, String label, Color color) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 18, color: color)),
        ],
      ),
    );
  }
}
