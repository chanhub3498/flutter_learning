import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> todos = [];

  final List<String> categories = ["全部", "工作", "学习", "生活"];
  String selectedCategory = "工作"; // 添加任务时的分类
  String filterCategory = "全部"; // 筛选用的分类

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("todos", jsonEncode(todos));
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString("todos");
    if (jsonString != null) {
      setState(() {
        todos = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
      });
    }
  }

  void _addTask() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      todos.add({
        "title": _controller.text.trim(),
        "done": false,
        "category": selectedCategory,
      });
      _controller.clear();
    });
    _saveTodos();
  }

  void _deleteTask(int index) {
    setState(() {
      todos.removeAt(index);
    });
    _saveTodos();
  }

  void _toggleDone(int index) {
    setState(() {
      todos[index]["done"] = !todos[index]["done"];
    });
    _saveTodos();
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("确认删除"),
        content: Text("你确定要删除 \"${todos[index]["title"]}\" 吗？"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("取消"),
          ),
          TextButton(
            onPressed: () {
              _deleteTask(index);
              Navigator.pop(context);
            },
            child: const Text("删除", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 按筛选条件过滤任务
    List<Map<String, dynamic>> filteredTodos = filterCategory == "全部"
        ? todos
        : todos.where((t) => t["category"] == filterCategory).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("待办清单（分类+筛选版）")),
      body: Column(
        children: [
          // 输入框 + 分类选择 + 添加按钮
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
                DropdownButton<String>(
                  value: selectedCategory,
                  items: categories
                      .where((c) => c != "全部") // 添加任务时不显示「全部」
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _addTask, child: const Text("添加")),
              ],
            ),
          ),

          // 分类筛选
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Text("筛选: "),
                DropdownButton<String>(
                  value: filterCategory,
                  items: categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      filterCategory = value!;
                    });
                  },
                ),
              ],
            ),
          ),

          // 清单
          Expanded(
            child: ListView.builder(
              itemCount: filteredTodos.length,
              itemBuilder: (context, index) {
                final task = filteredTodos[index];
                return ListTile(
                  leading: Checkbox(
                    value: task["done"],
                    onChanged: (_) {
                      int originalIndex = todos.indexOf(task);
                      _toggleDone(originalIndex);
                    },
                  ),
                  title: Text(
                    task["title"],
                    style: TextStyle(
                      decoration: task["done"]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task["done"] ? Colors.grey : Colors.black,
                    ),
                  ),
                  subtitle: Text("分类: ${task["category"]}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      int originalIndex = todos.indexOf(task);
                      _confirmDelete(originalIndex);
                    },
                  ),
                  onLongPress: () {
                    int originalIndex = todos.indexOf(task);
                    _confirmDelete(originalIndex);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
