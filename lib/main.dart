import 'package:flutter/material.dart';
import 'package:task_app/core/routes.dart';
import 'package:task_app/screens/login/login_screen.dart';
import 'package:task_app/screens/product_list/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        TMRoutes.login: (context) => const LoginScreen(),
        TMRoutes.productList: (context) => const ProductListScreen(),
      },
      home: const LoginScreen(),
    );
  }
}
