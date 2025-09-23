import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ButtonDemo());
  }
}

class ButtonDemo extends StatefulWidget {
  @override
  State<ButtonDemo> createState() => _ButtonDemoState();
}

class _ButtonDemoState extends State<ButtonDemo> {
  String _message = "点击按钮试试 👇";

  void _changeMessage(String newMessage) {
    setState(() {
      _message = newMessage;
    });
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Day 3 - 按钮练习")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              _message,
              style: const TextStyle(fontSize: 24, color: Colors.blue),
            ),
            const SizedBox(height: 30),
            // 保存按钮
            ElevatedButton(
              onPressed: () => _changeMessage("✅ 你点击了保存按钮"),
              child: const Text("保存"),
            ),
            const SizedBox(height: 10),
            // 取消按钮
            ElevatedButton(
              onPressed: () => _changeMessage("❌ 你点击了取消按钮"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text("取消"),
            ),
            const SizedBox(height: 10),
            // 弹出提示按钮
            ElevatedButton(
              onPressed: () => _showSnackBar(context, "🎉 弹出提示!"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("提示"),
            ),
          ],
        ),
      ),
    );
  }
}
