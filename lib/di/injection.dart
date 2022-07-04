import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api/app_client.dart';

final getIt = GetIt.instance;

void configureDependencies() async {
  getIt.registerSingleton<AppClient>(AppClient(Dio(BaseOptions(contentType: "application/json"))));
}
