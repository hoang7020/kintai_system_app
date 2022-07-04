// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ApplicationDao? _applicationDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Application` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `type` INTEGER NOT NULL, `date` INTEGER NOT NULL, `month` INTEGER NOT NULL, `year` INTEGER NOT NULL, `sHour` INTEGER NOT NULL, `sMinute` INTEGER NOT NULL, `eHour` INTEGER NOT NULL, `eMinute` INTEGER NOT NULL, `reason` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ApplicationDao get applicationDao {
    return _applicationDaoInstance ??=
        _$ApplicationDao(database, changeListener);
  }
}

class _$ApplicationDao extends ApplicationDao {
  _$ApplicationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _applicationInsertionAdapter = InsertionAdapter(
            database,
            'Application',
            (Application item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type,
                  'date': item.date,
                  'month': item.month,
                  'year': item.year,
                  'sHour': item.sHour,
                  'sMinute': item.sMinute,
                  'eHour': item.eHour,
                  'eMinute': item.eMinute,
                  'reason': item.reason
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Application> _applicationInsertionAdapter;

  @override
  Future<List<Application>> findAllApplication() async {
    return _queryAdapter.queryList('select * from Application',
        mapper: (Map<String, Object?> row) => Application(
            row['id'] as int?,
            row['type'] as int,
            row['date'] as int,
            row['month'] as int,
            row['year'] as int,
            row['sHour'] as int,
            row['sMinute'] as int,
            row['eHour'] as int,
            row['eMinute'] as int,
            row['reason'] as String));
  }

  @override
  Future<List<Application>> findAllApplicationByDate(String date) async {
    return _queryAdapter.queryList('select * from Application where date = ?1',
        mapper: (Map<String, Object?> row) => Application(
            row['id'] as int?,
            row['type'] as int,
            row['date'] as int,
            row['month'] as int,
            row['year'] as int,
            row['sHour'] as int,
            row['sMinute'] as int,
            row['eHour'] as int,
            row['eMinute'] as int,
            row['reason'] as String),
        arguments: [date]);
  }

  @override
  Future<void> insertApplication(Application application) async {
    await _applicationInsertionAdapter.insert(
        application, OnConflictStrategy.abort);
  }
}
