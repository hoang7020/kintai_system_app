import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kintai_system_app/blocs/load_list_application/load_application_bloc.dart';
import 'package:kintai_system_app/blocs/load_list_application/load_application_event.dart';
import 'package:kintai_system_app/blocs/load_list_application/load_applications_state.dart';
import 'package:kintai_system_app/blocs/submit_application/submit_application_bloc.dart';
import 'package:kintai_system_app/screens/daily_input_screen.dart';
import 'package:kintai_system_app/screens/problem_input_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:kintai_system_app/blocs/submit_application/submit_application_bloc.dart';
import 'package:kintai_system_app/blocs/submit_application/submit_application_event.dart';
import 'package:kintai_system_app/database/dabase_models/application_model.dart';

import '../database/dabase_models/application_model.dart';
import '../utils/connecting_icon.dart';

class ListApplicationScreen extends StatefulWidget {
  const ListApplicationScreen({Key? key}) : super(key: key);

  @override
  State<ListApplicationScreen> createState() => _ListApplicationScreenState();
}

class _ListApplicationScreenState extends State<ListApplicationScreen> {
  bool isVisible = false;
  late List<Application?> apps;
  int _selectedIndex = 0;

  @override
  void initState() {
    setState(() {
      isVisible = false;
    });
    context.read<LoadApplicationBloc>().add(ReloadApplicationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoadApplicationBloc, LoadApplicationState>(
            listener: (context, state) {
              if (state is LoadApplicationProcess) {
                context.loaderOverlay.show(widget: ConnectingIcon());
              } else if (state is LoadApplicationSuccess) {
                context.loaderOverlay.hide();
              } else {
                context.loaderOverlay.hide();
              }
            },
          )
        ],
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                  child: BlocBuilder<LoadApplicationBloc, LoadApplicationState>(
                builder: (context, state) {
                  if (state is LoadApplicationSuccess) {
                    return _buildList(context, state.apps);
                  } else {
                    return SizedBox(
                      height: 0,
                      width: 0,
                    );
                  }
                },
              )),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isVisible
                  ? FloatingActionButton(
                      onPressed: _onProblemButtonPressed,
                      heroTag: null,
                      child: const Icon(Icons.sick_outlined),
                    )
                  : const SizedBox(
                      width: 0,
                    ),
              const SizedBox(
                height: 10,
              ),
              isVisible
                  ? FloatingActionButton(
                      onPressed: _onOtButtonPressed,
                      heroTag: null,
                      child: const Icon(Icons.monetization_on_outlined),
                    )
                  : const SizedBox(
                      width: 0,
                    ),
              const SizedBox(
                height: 10,
              ),
              isVisible
                  ? FloatingActionButton(
                      onPressed: _onDailyInputButtonPressed,
                      heroTag: null,
                      child: const Icon(Icons.calendar_today),
                    )
                  : const SizedBox(
                      width: 0,
                    ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                onPressed: _onAddButtonPressed,
                heroTag: null,
                child: const Icon(Icons.add),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {

  }

  void _onAddButtonPressed() {
    setState(
      () {
        isVisible = !isVisible;
      },
    );
  }

  void _onDailyInputButtonPressed() {
    context.read<SubmitApplicationBloc>().add(
          SubmitApplicationButtonPressed(
            application: Application(null, 0, DateTime.now().day,
                DateTime.now().month, DateTime.now().year, 8, 00, 17, 00, ""),
          ),
        );
  }

  void _onOtButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const ProblemInputScreen(
                type: 2,
              )),
    ).then((value) =>
        context.read<LoadApplicationBloc>().add(ReloadApplicationEvent()));
  }

  void _onProblemButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const ProblemInputScreen(
                type: 1,
              )),
    ).then((value) =>
        context.read<LoadApplicationBloc>().add(ReloadApplicationEvent()));
  }

  Widget _buildList(BuildContext context, List<Application?> apps) {
    return SfCalendar(
      view: CalendarView.week,
      dataSource: ProblemApplication(apps),
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    );
  }
}

class ProblemApplication extends CalendarDataSource {
  ProblemApplication(List<Application?> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime(
        appointments![index].year,
        appointments![index].month,
        appointments![index].date,
        appointments![index].sHour,
        appointments![index].sMinute);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime(
        appointments![index].year,
        appointments![index].month,
        appointments![index].date,
        appointments![index].eHour,
        appointments![index].eMinute);
  }

  @override
  String getSubject(int index) {
    return appointments![index].reason;
  }

  @override
  Color getColor(int index) {
    switch (appointments![index].type) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
    }
    return Colors.white;
  }
}
