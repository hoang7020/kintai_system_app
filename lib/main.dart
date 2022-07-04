import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kintai_system_app/api/app_client.dart';
import 'package:kintai_system_app/blocs/load_list_unscheduled/load_list_unscheduled_bloc.dart';
import 'package:kintai_system_app/blocs/login/login_bloc.dart';
import 'package:kintai_system_app/di/injection.dart';

import '../api/app_client.dart';
import 'blocs/load_list_application/load_application_bloc.dart';
import 'blocs/submit_application/submit_application_bloc.dart';
import 'screens/login_screen.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
          BlocProvider<LoadApplicationBloc>(
              create: (_) => LoadApplicationBloc()),
          BlocProvider<LoadUnscheduledBloc>(
              create: (_) => LoadUnscheduledBloc()),
          BlocProvider<SubmitApplicationBloc>(
              create: (_) => SubmitApplicationBloc()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginScreen(),
        ));
  }
}
