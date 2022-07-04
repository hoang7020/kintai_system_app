import 'package:flutter/material.dart';

class ApproveApplicationScreen extends StatefulWidget {
  const ApproveApplicationScreen({Key? key}) : super(key: key);

  @override
  State<ApproveApplicationScreen> createState() => _ApproveApplicationScreenState();
}

class _ApproveApplicationScreenState extends State<ApproveApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Approve Screen"),
      ),
      body: Container(),
    );
  }
}
