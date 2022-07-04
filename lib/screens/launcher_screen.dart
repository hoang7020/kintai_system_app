import 'package:flutter/material.dart';
import 'package:kintai_system_app/screens/approve_application_screen.dart';
import 'package:kintai_system_app/screens/dash_board_screen.dart';
import 'package:kintai_system_app/screens/list_appicaiton_screen.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Launcher Screen"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: _onPressSubmitApplicationButton),
          IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: _onPressApproveApplicationButton),
          IconButton(
              icon: Icon(Icons.dashboard),
              onPressed: _onPressDashBoardButton),
        ],
      ),
    );
  }

  void _onPressSubmitApplicationButton() {
    print("_onPressSubmitApplicationButton");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListApplicationScreen()),
    );
  }

  void _onPressApproveApplicationButton() {
    print("_onPressApproveApplicationButton");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ApproveApplicationScreen()),
    );
  }

  void _onPressDashBoardButton() {
    print("_onPressDashBoardButton");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashBoardScreen()),
    );
  }
}
