import 'package:bloc_test/base/base_url.dart';
import 'package:bloc_test/model/employee_details_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'employee_service.g.dart';

@RestApi(baseUrl: BaseUrl.uri)
abstract class EmployeeService {
  factory EmployeeService(Dio dio, {String baseUrl}) = _EmployeeService;

  @GET('api/EmployeeSelfDetails/EmployeeDetails')
  Future<EmployeeDetailsResponse> getEmployeeDetails(
      @Header('Authorization') String token);
}
