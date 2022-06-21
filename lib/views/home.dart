import 'package:bloc_test/bloc/home/home_bloc.dart';
import 'package:bloc_test/bloc/login/login_bloc.dart';
import 'package:bloc_test/services/employee_service.dart';
import 'package:bloc_test/services/login_service.dart';
import 'package:bloc_test/views/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginService loginService = LoginService(Dio());
  EmployeeService employeeService = EmployeeService(Dio());
  late LoginBloc _loginBloc;
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc(loginService);
    _homeBloc = HomeBloc(employeeService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _loginBloc),
        BlocProvider(
            create: (context) => _homeBloc..add(LoadEmployeeDetails())),
      ],
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoggedOutState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Logged Out"),
            ));
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is HomeLoadedState) {
                        return Center(
                          child: Column(children: [
                            Text(state.employeeCode),
                            Text(state.name),
                            Text(state.mobileNumber),
                            Text(state.emailId),
                            Text(state.designationName),
                            Text(state.departmentName),
                            Text(state.officeName),
                          ]),
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _loginBloc.add(LogoutClickEvent());
                    },
                    child: const Text("Logout"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
