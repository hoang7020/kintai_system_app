abstract class LoadApplicationEvent {}

class ReloadApplicationEvent extends LoadApplicationEvent {}

class LoadCurrentApplication extends LoadApplicationEvent {
  final int day;
  final int month;
  final int year;

  LoadCurrentApplication({required this.day, required this.month, required this.year});
}
