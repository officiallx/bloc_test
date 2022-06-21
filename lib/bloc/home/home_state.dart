part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  final String name;
  final String employeeCode;
  final String emailId;
  final String designationName;
  final String mobileNumber;
  final String departmentName;
  final String officeName;

  const HomeLoadedState(
      this.name,
      this.employeeCode,
      this.emailId,
      this.designationName,
      this.mobileNumber,
      this.departmentName,
      this.officeName);
  @override
  List<Object?> get props => [
        name,
        employeeCode,
        emailId,
        designationName,
        mobileNumber,
        departmentName,
        officeName
      ];
}

class HomeDataLoadFailed extends HomeState {
  final String message;

  const HomeDataLoadFailed(this.message);
  @override
  List<Object?> get props => [message];
}
