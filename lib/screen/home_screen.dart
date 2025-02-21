import 'package:flutter/material.dart';
import '../db/db_service.dart';
import '../Model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

// Method to fetch the user data from the local database
  Future<void> loadUser() async {
    User? savedUser = await DBService.instance.getUser();
    setState(() {
      user = savedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${user!.displayName}"),
                  Text("Email: ${user!.email}"),
                  Text("Employee Code: ${user!.employeeCode}"),
                  Text("Company Code: ${user!.companyCode}"),
                ],
              ),
            ),
    );
  }
}
