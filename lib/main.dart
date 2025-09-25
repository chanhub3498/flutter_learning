import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "练习 2.3：分组 + 跳转",
      home: GroupedListScreen(),
    );
  }
}

class GroupedListScreen extends StatelessWidget {
  // 分组数据
  final Map<String, List<Map<String, dynamic>>> groupedItems = {
    "账户相关": [
      {"icon": Icons.person, "title": "个人资料", "subtitle": "查看和编辑信息"},
      {"icon": Icons.logout, "title": "退出登录", "subtitle": "安全退出账号"},
    ],
    "系统功能": [
      {"icon": Icons.home, "title": "首页", "subtitle": "欢迎进入主页"},
      {"icon": Icons.settings, "title": "设置", "subtitle": "调整应用配置"},
      {"icon": Icons.message, "title": "消息", "subtitle": "查看最新消息"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("分组 + 跳转")),
      body: ListView(
        children: groupedItems.entries.map((entry) {
          String groupTitle = entry.key;
          List<Map<String, dynamic>> items = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 分组标题
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  groupTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              // 组内的列表
              ...items.map((item) {
                return ListTile(
                  leading: Icon(item["icon"], color: Colors.blue),
                  title: Text(item["title"]),
                  subtitle: Text(item["subtitle"]),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          title: item["title"],
                          subtitle: item["subtitle"],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              Divider(), // 分隔线
            ],
          );
        }).toList(),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;

  DetailScreen({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "这是 $title 页面\n$subtitle",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
