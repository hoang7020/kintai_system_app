import 'package:flutter/material.dart';
import 'package:kintai_system_app/screens/widget/leader_board.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        overlayOpacity: 0.8,
        child: LeaderBoard(),
      ),
    );
  }
}
