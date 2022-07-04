import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kintai_system_app/blocs/load_list_application/load_application_event.dart';
import 'package:kintai_system_app/blocs/load_list_application/load_applications_state.dart';
import 'package:kintai_system_app/database/dabase_models/application_model.dart';

import '../../database/db_singleton.dart';

class LoadApplicationBloc extends Bloc<LoadApplicationEvent, LoadApplicationState> {

  LoadApplicationBloc() : super(LoadApplicationInitial()) {
    on<ReloadApplicationEvent>(_onReloadApplicationEvent);
  }

  void _onReloadApplicationEvent(ReloadApplicationEvent event, Emitter emit) async {
    emit(LoadApplicationProcess());
    final database = await DbSingleton().getDatabase();
    List<Application?> apps = await database.applicationDao.findAllApplication();
    emit(LoadApplicationSuccess(apps: apps));
  }

}