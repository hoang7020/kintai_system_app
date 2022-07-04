import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kintai_system_app/blocs/submit_application/submit_application_bloc.dart';
import 'package:kintai_system_app/blocs/submit_application/submit_application_event.dart';
import 'package:kintai_system_app/database/dabase_models/application_model.dart';

class ProblemInputScreen extends StatefulWidget {

  final int type;

  const ProblemInputScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ProblemInputScreen> createState() => _ProblemInputScreenState();
}

class _ProblemInputScreenState extends State<ProblemInputScreen> {
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _reasonController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _dateController.text =
        "${_convert(_selectedDate.day)}-${_convert(_selectedDate.month)}-${_selectedDate.year}";
    _startTimeController.text =
        "${_convert(_selectedStartTime.hour)}:${_convert(_selectedStartTime.minute)}";
    _endTimeController.text =
        "${_convert(_selectedEndTime.hour)}:${_convert(_selectedEndTime.minute)}";
    _reasonController.text = "N/A";
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            "${_convert(_selectedDate.day)}-${_convert(_selectedDate.month)}-${_selectedDate.year}";
      });
  }

  void _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );
    if (picked != null && picked != _selectedStartTime)
      setState(() {
        _selectedStartTime = picked;
        _startTimeController.text =
            "${_convert(_selectedStartTime.hour)}:${_convert(_selectedStartTime.minute)}";
      });
  }

  void _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );
    if (picked != null && picked != _selectedEndTime)
      setState(() {
        _selectedEndTime = picked;
        _endTimeController.text =
            "${_convert(_selectedEndTime.hour)}:${_convert(_selectedEndTime.minute)}";
      });
  }

  String _convert(int time) {
    if (time < 10) {
      return "0${time}";
    } else {
      return "${time}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submission Form"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    controller: _dateController,
                    decoration: const InputDecoration(
                        labelText: 'Date',
                        prefixIcon: Icon(Icons.calendar_today)),
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 4),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => _selectStartTime(context),
                          controller: _startTimeController,
                          decoration: const InputDecoration(
                              labelText: 'Start Time',
                              prefixIcon: Icon(Icons.timer)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 4),
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => _selectEndTime(context),
                          controller: _endTimeController,
                          decoration: const InputDecoration(
                              labelText: 'End Time',
                              prefixIcon: Icon(Icons.timer_off)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: TextFormField(
                    minLines: 5,
                    maxLines: 10,
                    controller: _reasonController,
                    decoration: const InputDecoration(labelText: 'Reason'),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(200, 50),
                          backgroundColor: Color(0xFFBE0000),
                          textStyle: TextStyle(color: Colors.black)),
                      onPressed: _onPressOK,
                      child: const Text("OK"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(200, 50),
                          backgroundColor: Color(0xFFBE0000),
                          textStyle: TextStyle(color: Colors.black)),
                      child: const Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPressOK() {
    context.read<SubmitApplicationBloc>().add(
          SubmitApplicationButtonPressed(
            application: Application(
                null,
                widget.type,
                _selectedDate.day,
                _selectedDate.month,
                _selectedDate.year,
                _selectedStartTime.hour,
                _selectedStartTime.minute,
                _selectedEndTime.hour,
                _selectedEndTime.minute,
                _reasonController.text),
          ),
        );
    Navigator.pop(context);
  }
}
