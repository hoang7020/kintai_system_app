import 'dart:async';
import 'package:floor/floor.dart';
import 'package:kintai_system_app/database/dabase_models/application_model.dart';
import 'package:kintai_system_app/database/database_daos/application_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Application])
abstract class AppDatabase extends FloorDatabase {
  ApplicationDao get applicationDao;
}
