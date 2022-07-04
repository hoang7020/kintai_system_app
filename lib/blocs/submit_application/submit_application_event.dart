import 'package:kintai_system_app/database/dabase_models/application_model.dart';

abstract class SubmitApplicationEvent {}

class SubmitApplicationButtonPressed extends SubmitApplicationEvent {
  final Application application;

  SubmitApplicationButtonPressed({required this.application});
}
