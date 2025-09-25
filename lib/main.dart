import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TodoListPage());
  }
}

class TodoListPage extends StatefulWidget {
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // 每个任务用 Map 存储：任务内容 + 完成状态 + 日期
  final List<Map<String, dynamic>> todos = [
    {"title": "学习 Flutter", "done": false, "date": DateTime.now()},
    {"title": "买牛奶", "done": false, "date": DateTime.now()},
    {"title": "运动 30 分钟", "done": true, "date": DateTime.now()},
  ];

  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      todos.add({
        "title": "✅ ${_controller.text.trim()}",
        "done": false,
        "date": DateTime.now(), // 保存当前日期
      });
      _controller.clear();
    });
  }

  void _toggleDone(int index) {
    setState(() {
      todos[index]["done"] = !todos[index]["done"];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("待办清单（带日期）")),
      body: Column(
        children: [
          // 输入框
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "输入新任务",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _addTask, child: const Text("添加")),
              ],
            ),
          ),
          // 列表
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final task = todos[index];
                return ListTile(
                  leading: Checkbox(
                    value: task["done"],
                    onChanged: (value) => _toggleDone(index),
                  ),
                  title: Text(
                    task["title"],
                    style: TextStyle(
                      fontSize: 18,
                      // 👇 根据任务是否完成，动态改变颜色
                      color: task["done"]
                          ? const Color.fromARGB(255, 133, 22, 22)
                          : Colors.black,
                      decoration: task["done"]
                          ? TextDecoration
                                .lineThrough // 已完成加删除线
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text("创建日期: ${_formatDate(task["date"])}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
