import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/user_model.dart';

class ApiService {
  // API endpoint URL
  static const String apiUrl = 'https://api.ezuite.com/api/External_Api/Mobile_Api/Invoke';

  Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "API_Body": [{"Unique_Id": "", "Pw": password}],
        "Api_Action": "GetUserData",
        "Company_Code": username
      }),
    );

// Check if the request was successful
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['Status_Code'] == 200) {
        return User.fromJson(responseData['Response_Body'][0]);
      }
    }
    return null;
  }
}
