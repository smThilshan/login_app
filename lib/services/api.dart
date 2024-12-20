import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> loginAPI(String username, String password) async {
  final url =
      Uri.parse('https://api.ezuite.com/api/External_Api/Mobile_Api/Invoke');
  final body = {
    "API_Body": [
      {
        "Unique_Id": username,
        "Pw": password,
      }
    ],
    "Api_Action": "GetUserData",
    "Company_Code": username,
  };

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Failed to login");
  }
}
