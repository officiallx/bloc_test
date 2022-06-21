import 'package:bloc_test/base/base_url.dart';
import 'package:bloc_test/model/login_request.dart';
import 'package:bloc_test/model/login_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'login_service.g.dart';

@RestApi(baseUrl: BaseUrl.uri)
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @POST('api/Auth/GetLoginToken')
  Future<LoginResponse> getToken(@Body() LoginRequest loginRequest);

  @POST('api/Auth/GetRefreshToken')
  Future<LoginResponse> getRefreshToken(@Body() LoginResponse loginResponse);
}
