import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../db/db_service.dart';
import 'home_screen.dart';
import '../Model/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

// Method to handle login process
  Future<void> handleLogin() async {
    setState(() {
      isLoading = true;
    });

    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    User? user = await ApiService().login(username, password);

    if (user != null) {
      await DBService.instance.saveUser(user);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Successfully')));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Credentials')));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: 'Username')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: handleLogin, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}
