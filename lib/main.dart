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
        appBar: AppBar(title: const Text("Row + Column Example")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("上面 🏔️", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("左边 🏠", style: TextStyle(fontSize: 24)),
                  SizedBox(width: 20),
                  Text("右边 🚗", style: TextStyle(fontSize: 24)),
                ],
              ),
              const SizedBox(height: 20),
              const Text("下面 🌊", style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
