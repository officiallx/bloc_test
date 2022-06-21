import 'package:bloc_test/bloc/login/login_bloc.dart';
import 'package:bloc_test/services/login_service.dart';
import 'package:bloc_test/views/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameCont = TextEditingController();
  final TextEditingController _passCont = TextEditingController();
  LoginService loginService = LoginService(Dio());
  late SharedPreferences preferences;
  late LoginBloc _loginBloc;

  Future initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initializePreference();
    _loginBloc = LoginBloc(loginService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            setState(() {
              const Center(
                child: CircularProgressIndicator(),
              );
            });
          }
          if (state is LoginSuccessState) {
            print(state.loginResponse.token!);
            preferences.setString("TOKEN", state.loginResponse.token!);
            preferences.setString(
                "REFRESHTOKEN", state.loginResponse.refreshToken!);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ),
            );
          }
          if (state is LoginFailedState) {
            setState(() {
              print("failed");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Failed to Login"),
              ));
            });
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    const Text("Login Page"),
                    TextFormField(
                      maxLines: 1,
                      controller: _usernameCont,
                      decoration: const InputDecoration(hintText: "Username"),
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: _passCont,
                      decoration: const InputDecoration(hintText: "Password"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _loginBloc.add(LoginClickEvent(
                            _usernameCont.text, _passCont.text));
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
