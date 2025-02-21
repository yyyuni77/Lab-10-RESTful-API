import 'package:flutter/material.dart';
import 'api_service.dart';
import 'register_page.dart'; // Import the registration page
import 'profile_page.dart'; // Import the profile page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiService apiService = ApiService();
  String email = '';
  String password = '';

  void login() async {
    try {
      await apiService.login(email, password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilePage()));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => email = value,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) => password = value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(onPressed: login, child: Text('Login')),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage()));
              },
              child: Text('Don’t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}