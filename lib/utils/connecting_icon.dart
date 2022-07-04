import 'package:flutter/material.dart';

class ConnectingIcon extends StatelessWidget {
  const ConnectingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
