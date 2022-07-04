import 'app_database.dart';

class DbSingleton {
  static final DbSingleton _singleton = DbSingleton._internal();

  factory DbSingleton() {
    return _singleton;
  }

  DbSingleton._internal();

  getDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database;
  }
}
