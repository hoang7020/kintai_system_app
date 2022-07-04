import 'package:kintai_system_app/api/api_models/api_response.dart';

abstract class LoadUnscheduledState {}

class LoadUnscheduledInitial extends LoadUnscheduledState {}

class LoadUnscheduledProcess extends LoadUnscheduledState {}

class LoadUnscheduledSuccess extends LoadUnscheduledState {
  List<Employee>? employees;

  LoadUnscheduledSuccess({required this.employees});
}