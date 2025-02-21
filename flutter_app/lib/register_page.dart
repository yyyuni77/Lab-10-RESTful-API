import 'package:flutter/material.dart';
import 'api_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ApiService apiService = ApiService();
  String name = '';
  String email = '';
  String password = '';

  void register() async {
    try {
      await apiService.register(name, email, password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful!')));
      Navigator.pop(context); // Go back to login page after registration
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => name = value,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              onChanged: (value) => email = value,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) => password = value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(onPressed: register, child: Text('Register')),
          ],
        ),
      ),
    );
  }
}