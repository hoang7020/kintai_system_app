import 'package:floor/floor.dart';
import 'package:kintai_system_app/database/dabase_models/application_model.dart';

@dao
abstract class ApplicationDao {
  @Query('select * from Application')
  Future<List<Application>> findAllApplication();

  @Query('select * from Application where date = :date')
  Future<List<Application>> findAllApplicationByDate(String date);
  
  @insert
  Future<void> insertApplication(Application application);
}
