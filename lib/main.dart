import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MultiButtonExample());
  }
}

class MultiButtonExample extends StatelessWidget {
  void _showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("多个按钮一行")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 平均分布
          children: [
            ElevatedButton.icon(
              onPressed: () => _showMessage(context, "✅ 保存成功"),
              icon: Icon(Icons.save),
              label: Text("保存"),
            ),
            ElevatedButton.icon(
              onPressed: () => _showMessage(context, "❌ 已取消"),
              icon: Icon(Icons.cancel),
              label: Text("取消"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            ),
            ElevatedButton.icon(
              onPressed: () => _showMessage(context, "🗑 已删除"),
              icon: Icon(Icons.delete),
              label: Text("删除"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
