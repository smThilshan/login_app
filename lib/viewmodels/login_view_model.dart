import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/services/database_helper.dart';
import '../models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  Future<void> login(String username, String password) async {
    // Set loading state to true when the login process starts
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final url = 'https://api.ezuite.com/api/External_Api/Mobile_Api/Invoke';
    final body = jsonEncode({
      "API_Body": [
        {"Unique_Id": "", "Pw": password}
      ],
      "Api_Action": "GetUserData",
      "Company_Code": "info@enhanzer.com"
    });

    try {
      print('Sending login request...');

      // Send HTTP POST request
      final response = await http
          .post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      )
          .timeout(Duration(seconds: 15), onTimeout: () {
        throw TimeoutException("Request timed out");
      });

      print('Response received: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Parse the response body if successful
        final data = jsonDecode(response.body);
        final user = UserModel.fromJson(data['Response_Body'][0]);

        // Save user to database
        await DatabaseHelper.instance.saveUser(user);

        // Update loading state and notify listeners
        isLoading = false;
        notifyListeners();

        // Navigate to the next screen (e.g., home screen)
      } else {
        // Handle invalid login attempt
        errorMessage = 'Invalid username or password';
      }
    } catch (e) {
      // Catch any errors (e.g., network issues)
      print('Error occurred: $e');
      errorMessage = 'An error occurred';
    } finally {
      // Ensure loading state is updated in the finally block
      isLoading = false;
      notifyListeners();
    }
  }
}
