import 'package:flutter/material.dart';
import 'package:login_app/view/login_screen.dart';
import 'package:login_app/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login',
        home: LoginScreen(),
      ),
    );
  }
}
