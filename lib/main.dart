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
        appBar: AppBar(title: const Text("Column Example")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
            crossAxisAlignment: CrossAxisAlignment.center, // 水平居中
            children: const [
              Text("第一行 😀", style: TextStyle(fontSize: 24)),
              Text("第二行 🚀", style: TextStyle(fontSize: 24)),
              Text("第3行 🎉", style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
