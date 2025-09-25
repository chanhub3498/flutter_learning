import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "练习 4 升级版：用户注册和列表",
      home: RegisterScreen(),
    );
  }
}

class User {
  final String username;
  final String email;
  final String password;

  User({required this.username, required this.email, required this.password});
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<User> _users = []; // 保存所有用户

  String _username = "";
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("注册页面")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "用户名"),
                onSaved: (value) => _username = value!,
                validator: (value) => value!.isEmpty ? "请输入用户名" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "邮箱"),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value!,
                validator: (value) => value!.contains("@") ? null : "请输入有效的邮箱",
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "密码"),
                obscureText: true,
                onSaved: (value) => _password = value!,
                validator: (value) => value!.length < 6 ? "密码至少 6 位" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("注册"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() {
                      _users.add(
                        User(
                          username: _username,
                          email: _email,
                          password: _password,
                        ),
                      );
                    });
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("注册成功：$_username")));
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("查看用户列表"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserListScreen(users: _users),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserListScreen extends StatelessWidget {
  final List<User> users;

  UserListScreen({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("用户列表")),
      body: users.isEmpty
          ? Center(child: Text("暂无用户"))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: Icon(Icons.person, color: Colors.blue),
                  title: Text(user.username),
                  subtitle: Text(user.email),
                );
              },
            ),
    );
  }
}
