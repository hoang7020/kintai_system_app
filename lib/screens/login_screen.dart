import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kintai_system_app/blocs/login/login_bloc.dart';
import 'package:kintai_system_app/blocs/login/login_event.dart';
import 'package:kintai_system_app/blocs/login/login_state.dart';
import 'package:kintai_system_app/screens/launcher_screen.dart';
import 'package:kintai_system_app/screens/list_appicaiton_screen.dart';
import 'package:kintai_system_app/utils/connecting_icon.dart';
import 'package:loader_overlay/loader_overlay.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayOpacity: 0.8,
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                context.loaderOverlay.show(widget: ConnectingIcon());
              } else {
                context.loaderOverlay.hide();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LauncherScreen()),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset(
                  'images/ic_rakuten.png',
                  height: 200,
                  width: 200,
                ),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFBE0000),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFBE0000),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  child: ElevatedButton.icon(
                    onPressed: _onLoginButtonPressed,
                    icon: const Icon(Icons.vpn_key),
                    label: const Text("Login"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  height: 60,
                  width: double.infinity,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginButtonPressed() {
    context
        .read<LoginBloc>()
        .add(LoginButtonPressed(username: "hoang", password: "pham"));
  }
}
