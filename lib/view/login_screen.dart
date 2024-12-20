import 'package:flutter/material.dart';
import 'package:login_app/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            loginViewModel.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      await loginViewModel.login(
                        usernameController.text,
                        passwordController.text,
                      );
                    },
                    child: Text('Login'),
                  ),
            SizedBox(height: 20),
            if (loginViewModel.errorMessage != null)
              Text(
                loginViewModel.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}


  // void login(BuildContext context, String username, String password) async {
  //   try {
  //     final response = await loginAPI(username, password);
  //     if (response['Status_Code'] == 200) {
  //       saveResponseToDatabase(response);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Login Successful!")),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Login Failed!")),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error: $e")),
  //     );
  //   }
  // }

  // void saveResponseToDatabase(Map<String, dynamic> response) async {
  //   final db = await initDatabase();
  //   final userData = response['Response_Body'][0];
  //   await saveUserData(db, userData);
  // }

