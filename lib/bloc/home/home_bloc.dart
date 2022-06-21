import 'package:bloc/bloc.dart';
import 'package:bloc_test/services/employee_service.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EmployeeService employeeService;
  HomeBloc(this.employeeService) : super(HomeLoading()) {
    on<LoadEmployeeDetails>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("TOKEN");
      var response =
          await employeeService.getEmployeeDetails("Bearer " + token!);
      if (response.name != "") {
        emit(
          HomeLoadedState(
              response.name!,
              response.employeeCode!,
              response.emailId!,
              response.designationName!,
              response.mobileNumber!,
              response.departmentName!,
              response.officeName!),
        );
      } else {
        emit(const HomeDataLoadFailed("Failed To Load Data"));
      }
    });
  }
}
