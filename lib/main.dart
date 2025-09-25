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
      title: 'Day1 Flutter Demo 进阶',
      home: const ProfileCardInteractive(),
    );
  }
}

class ProfileCardInteractive extends StatefulWidget {
  const ProfileCardInteractive({super.key});

  @override
  State<ProfileCardInteractive> createState() => _ProfileCardInteractiveState();
}

class _ProfileCardInteractiveState extends State<ProfileCardInteractive> {
  String _status = "Flutter 新手，正在学习列表和布局。";

  void _updateStatus() {
    setState(() {
      _status = "我已学会 Flutter 基础控件 🎉";
    });

    // 弹窗提示
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("状态更新"),
        content: Text(_status),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("确定"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("个人信息卡片互动版")),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=5',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '小六壬',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _status,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.school, color: Colors.blue),
                  Icon(Icons.code, color: Colors.green),
                  Icon(Icons.sports_basketball, color: Colors.orange),
                ],
              ),
              const SizedBox(height: 16),

              // ✅ 多个按钮放在 Row 中
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _updateStatus, // 按钮 A 更新状态
                    child: const Text("按钮 A"),
                  ),
                  ElevatedButton(
                    onPressed: () {}, // 按钮 B 先空着
                    child: const Text("按钮 B"),
                  ),
                  ElevatedButton(
                    onPressed: () {}, // 按钮 C 先空着
                    child: const Text("按钮 C"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
