import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kintai_system_app/api/app_client.dart';
import 'package:kintai_system_app/blocs/load_list_unscheduled/load_list_unscheduled_state.dart';
import 'package:kintai_system_app/blocs/load_list_unscheduled/load_list_unsheduled_event.dart';

import '../../di/injection.dart';

class LoadUnscheduledBloc
    extends Bloc<LoadUnscheduledEvent, LoadUnscheduledState> {
  AppClient appClient = getIt.get<AppClient>();

  LoadUnscheduledBloc() : super(LoadUnscheduledInitial()) {
    on<StartLoadingUnscheduled>(_onStartLoadingUnscheduled);
  }

  void _onStartLoadingUnscheduled(
      StartLoadingUnscheduled event, Emitter emit) async {
    emit(LoadUnscheduledProcess());
    await Future.delayed(const Duration(seconds: 1));
    await appClient
        .loadUnschduledList()
        // .then((value) => print(value.employees?.elementAt(0).avatar));
        .then((value) => emit(LoadUnscheduledSuccess(employees: value.employees)));
  }
}
