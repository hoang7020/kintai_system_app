import 'package:floor/floor.dart';

@entity
class Application {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int type;
  int date;
  int month;
  int year;
  int sHour;
  int sMinute;
  int eHour;
  int eMinute;
  String reason;

  Application(this.id, this.type, this.date, this.month, this.year, this.sHour,
      this.sMinute, this.eHour, this.eMinute, this.reason);
}
