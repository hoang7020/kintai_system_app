import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kintai_system_app/api/api_models/api_response.dart';
import 'package:kintai_system_app/api/api_models/bot_request.dart';
import 'package:kintai_system_app/api/api_models/bot_response.dart';
import 'package:kintai_system_app/api/api_models/submission.dart';
import 'package:kintai_system_app/blocs/submit_application/submit_application_event.dart';
import 'package:kintai_system_app/blocs/submit_application/submit_application_state.dart';
import 'package:kintai_system_app/database/app_database.dart';
import 'package:kintai_system_app/database/dabase_models/application_model.dart';
import 'package:kintai_system_app/database/db_singleton.dart';
import 'package:kintai_system_app/api/app_client.dart';
import 'package:kintai_system_app/di/injection.dart';

class SubmitApplicationBloc
    extends Bloc<SubmitApplicationEvent, SubmitApplicationState> {
  AppClient appClient = getIt.get<AppClient>();

  SubmitApplicationBloc() : super(SubmitApplicationInitial()) {
    on<SubmitApplicationButtonPressed>(_onSubmitApplicationButtonPressed);
  }

  void _onSubmitApplicationButtonPressed(
      SubmitApplicationButtonPressed event, Emitter emit) async {
    // final database = await DbSingleton().getDatabase();
    // await database.applicationDao.insertApplication(event.application);

    // print("send message");
    //
    // BotRequest request = BotRequest(
    //     receiver: "ZAV15p/TBIncduWqPgt5SA==",
    //     minApiVersion: 1,
    //     sender: Sender(
    //         name: "Rakuten Bot", avatar: "http://avatar.example.com"),
    //     trackingData: "tracking data",
    //     type: "text",
    //     text: "Hello");
    //
    // BotResponse response = await appClient.sendMessage(
    //     "4f2bacd74ca7e6da-7e378160e6eb98ef-9815e7c7b177fad",
    //     request);
    //
    // print(request.toJson());
    // print(request.sender!.toJson());
    // print(response.toJson());

    Submission submission = Submission(
        userName: "hoang",
        appType: "late",
        date: DateTime.now(),
        startHour: 12,
        startMinute: 10,
        endHour: 11,
        endMinute: 30);

    var response = await appClient.submit(submission).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          print("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
          break;
      }
    });

    // print(response.response.statusCode);

    // if (response.response.statusCode == 200) {
    //   print("Submit Success");
    //   emit(SubmitApplicationSuccess());
    // } else {
    //   print("Submit Fail!!!");
    // }
  }
}
