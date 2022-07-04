import '../../database/dabase_models/application_model.dart';

abstract class LoadApplicationState {}

class LoadApplicationInitial extends LoadApplicationState {}

class LoadApplicationProcess extends LoadApplicationState {}

class LoadApplicationSuccess extends LoadApplicationState {
  final List<Application?> apps;
  LoadApplicationSuccess({required this.apps});
}