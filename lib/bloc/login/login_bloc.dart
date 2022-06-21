import 'package:bloc/bloc.dart';
import 'package:bloc_test/model/login_request.dart';
import 'package:bloc_test/model/login_response.dart';
import 'package:bloc_test/services/login_service.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService;

  LoginBloc(this.loginService) : super(LoginLoadingState()) {
    on<LoginClickEvent>((event, emit) async {
      emit(LoginLoadingState());
      LoginRequest _loginRequest =
          LoginRequest(userName: event.username, password: event.password);
      try {
        final response = await loginService.getToken(_loginRequest);
        if (response.token != "") {
          LoginResponse refreshTokenRequest = LoginResponse(
              token: response.token, refreshToken: response.refreshToken);
          final refreshTokenResponse =
              await loginService.getRefreshToken(refreshTokenRequest);
          if (refreshTokenResponse.token != "") {
            emit(LoginSuccessState(refreshTokenResponse));
          }
        } else {
          emit(const LoginFailedState("Username or Password Incorrect"));
        }
      } catch (ex) {
        emit(LoginFailedState(ex.toString()));
      }
    });
    on<LogoutClickEvent>(
      (event, emit) {
        //Token Remove eta garney
        emit(LoggedOutState());
      },
    );
  }
}
