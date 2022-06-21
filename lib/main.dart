import 'package:bloc_test/services/employee_service.dart';
import 'package:bloc_test/services/login_service.dart';
import 'package:bloc_test/views/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Test',
      home: MultiRepositoryProvider(providers: [
        RepositoryProvider(
          create: (context) => LoginService(Dio()),
        ),
        RepositoryProvider(
          create: (context) => EmployeeService(Dio()),
        ),
      ], child: const LoginPage()),
      debugShowCheckedModeBanner: false,
    );
  }
}
