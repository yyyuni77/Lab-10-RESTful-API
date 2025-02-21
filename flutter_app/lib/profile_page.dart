import 'package:flutter/material.dart';
import 'api_service.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? user;
  String updatedName = '';
  String updatedEmail = '';

  void fetchUser() async {
    user = await apiService.getUser();
    setState(() {
      updatedName = user?['name'] ?? '';
      updatedEmail = user?['email'] ?? '';
    });
  }

  void updateUser() async {
    await apiService.updateUser(updatedName, updatedEmail);
    fetchUser();
  }

  void deleteUser() async {
    await apiService.deleteUser();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (value) => updatedName = value,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                    ),
                    controller: TextEditingController(text: updatedName),
                  ),
                  TextField(
                    onChanged: (value) => updatedEmail = value,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    controller: TextEditingController(text: updatedEmail),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updateUser,
                    child: Text('Update Profile'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: deleteUser,
                    child: Text('Delete Account'),
                  ),
                ],
              ),
            ),
    );
  }
}