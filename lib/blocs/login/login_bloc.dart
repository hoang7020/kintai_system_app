import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kintai_system_app/api/api_models/api_request.dart';
import 'package:kintai_system_app/api/app_client.dart';
import 'package:kintai_system_app/blocs/login/login_event.dart';
import 'package:kintai_system_app/blocs/login/login_state.dart';
import 'package:kintai_system_app/di/injection.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AppClient appClient = getIt.get<AppClient>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(LoginButtonPressed event, Emitter emit) async {
    emit(LoginLoading());
    await appClient.login(LoginRequest(username: "hoang7020", password: "123456"))
    .then((value) {
      emit(LoginSuccess());
    });
  }
}
