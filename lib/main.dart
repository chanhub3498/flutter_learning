import 'dart:async';
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
  final List<Map<String, dynamic>> todos = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = "";

  void _addTask(BuildContext context) async {
    if (_controller.text.trim().isEmpty) return;

    // 选择提醒时间
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    DateTime now = DateTime.now();
    DateTime reminderTime;
    if (pickedTime != null) {
      reminderTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    } else {
      reminderTime = now;
    }

    setState(() {
      todos.add({
        "title": _controller.text.trim(),
        "done": false,
        "date": now,
        "reminder": reminderTime,
      });
      _controller.clear();
    });

    // 设置提醒
    Duration delay = reminderTime.difference(DateTime.now());
    if (delay.isNegative) return;
    Timer(delay, () {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("提醒：${todos.last["title"]}")));
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

  /// 📝 编辑任务
  void _editTask(int index) {
    TextEditingController editController = TextEditingController(
      text: todos[index]["title"],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("编辑任务"),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(labelText: "修改任务内容"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("取消"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todos[index]["title"] = editController.text.trim();
                });
                Navigator.pop(context);
              },
              child: const Text("保存"),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  String _formatTime(DateTime date) {
    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final filteredTodos = todos
        .where(
          (task) =>
              task["title"].toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("待办清单（带提醒 + 编辑功能）")),
      body: Column(
        children: [
          // 搜索框
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "搜索任务",
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = "";
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim();
                });
              },
            ),
          ),
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
                ElevatedButton(
                  onPressed: () => _addTask(context),
                  child: const Text("添加"),
                ),
              ],
            ),
          ),
          // 列表
          Expanded(
            child: filteredTodos.isEmpty
                ? const Center(
                    child: Text(
                      "没有找到相关任务",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final task = filteredTodos[index];
                      final taskIndex = todos.indexOf(task);

                      return ListTile(
                        leading: Checkbox(
                          value: task["done"],
                          onChanged: (value) => _toggleDone(taskIndex),
                        ),
                        title: Text(
                          task["title"],
                          style: TextStyle(
                            decoration: task["done"]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text(
                          "创建: ${_formatDate(task["date"])}  提醒: ${_formatTime(task["reminder"])}",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editTask(taskIndex),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(taskIndex),
                            ),
                          ],
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
