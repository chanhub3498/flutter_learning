import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "练习 2：带图标的列表",
      home: IconListScreen(),
    );
  }
}

class IconListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {"icon": Icons.home, "title": "首页", "subtitle": "欢迎进入主页"},
    {"icon": Icons.person, "title": "个人资料", "subtitle": "查看和编辑信息"},
    {"icon": Icons.settings, "title": "设置", "subtitle": "调整应用配置"},
    {"icon": Icons.message, "title": "消息", "subtitle": "查看最新消息"},
    {"icon": Icons.logout, "title": "退出登录", "subtitle": "安全退出账号"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("带图标的列表")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(items[index]["icon"], color: Colors.blue),
            title: Text(items[index]["title"]),
            subtitle: Text(items[index]["subtitle"]),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("你点击了 ${items[index]["title"]}")),
              );
            },
          );
        },
      ),
    );
  }
}
