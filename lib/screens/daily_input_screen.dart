import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyInputScreen extends StatefulWidget {
  const DailyInputScreen({Key? key}) : super(key: key);

  @override
  State<DailyInputScreen> createState() => _DailyInputScreenState();
}

class _DailyInputScreenState extends State<DailyInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Input"),
      ),
    );
  }
}
