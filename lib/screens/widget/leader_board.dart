import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kintai_system_app/blocs/load_list_unscheduled/load_list_unscheduled_bloc.dart';
import 'package:kintai_system_app/blocs/load_list_unscheduled/load_list_unscheduled_state.dart';
import 'package:kintai_system_app/blocs/load_list_unscheduled/load_list_unsheduled_event.dart';
import 'package:kintai_system_app/utils/connecting_icon.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kintai_system_app/api/api_models/api_response.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  late List<Employee>? list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      list = [];
    });
    context.read<LoadUnscheduledBloc>().add(StartLoadingUnscheduled());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadUnscheduledBloc, LoadUnscheduledState>(
      builder: (context, state) {
        if (state is LoadUnscheduledSuccess) {
          print('avata');
          print(state.employees?.elementAt(0).avatar);
          context.loaderOverlay.hide();
          return Column(
            children: [
              Flexible(
                flex: 5,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 150, right: 150),
                          child: Column(
                            children: [
                              Text(
                                "2",
                                style: GoogleFonts.pacifico(
                                  textStyle: TextStyle(
                                      color: Colors.blue,
                                      letterSpacing: .5,
                                      fontSize: 30),
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      state.employees!.elementAt(1).avatar!),
                                  backgroundColor: Colors.red.shade800,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    state.employees!.elementAt(1).name!,
                                    style: GoogleFonts.pacifico(
                                      textStyle: TextStyle(
                                        color: Colors.blue,
                                        letterSpacing: .5,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.employees!.elementAt(1).uTime!.toString(),
                                    style: GoogleFonts.satisfy(
                                      textStyle: TextStyle(
                                        color: Colors.red,
                                        letterSpacing: .5,
                                        fontSize: 10,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 150),
                          child: Column(
                            children: [
                              Text(
                                "3",
                                style: GoogleFonts.pacifico(
                                  textStyle: TextStyle(
                                      color: Colors.blue,
                                      letterSpacing: .5,
                                      fontSize: 30),
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      state.employees!.elementAt(2).avatar!),
                                  backgroundColor: Colors.red.shade800,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    state.employees!.elementAt(2).name!,
                                    style: GoogleFonts.pacifico(
                                      textStyle: TextStyle(
                                        color: Colors.blue,
                                        letterSpacing: .5,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.employees!.elementAt(2).uTime!.toString(),
                                    style: GoogleFonts.satisfy(
                                      textStyle: TextStyle(
                                        color: Colors.red,
                                        letterSpacing: .5,
                                        fontSize: 10,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Text(
                                "1",
                                style: GoogleFonts.pacifico(
                                  textStyle: TextStyle(
                                      color: Colors.blue,
                                      letterSpacing: .5,
                                      fontSize: 30),
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      state.employees!.elementAt(0).avatar!),
                                  backgroundColor: Colors.red.shade800,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    state.employees!.elementAt(0).name!,
                                    style: GoogleFonts.pacifico(
                                      textStyle: TextStyle(
                                        color: Colors.blue,
                                        letterSpacing: .5,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.employees!.elementAt(0).uTime!.toString(),
                                    style: GoogleFonts.satisfy(
                                      textStyle: TextStyle(
                                        color: Colors.red,
                                        letterSpacing: .5,
                                        fontSize: 10,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 5,
                child: _buildUnscheduledList(state.employees!.sublist(3)),
              )
            ],
          );
        } else {
          context.loaderOverlay.show(widget: ConnectingIcon());
          return SizedBox();
        }
      },
    );
  }

  Widget _buildUnscheduledList(List<Employee> list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      (index + 3).toString(),
                      style: GoogleFonts.pacifico(
                        textStyle: TextStyle(
                            color: Colors.blue,
                            letterSpacing: .5,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, top: 10),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(list.elementAt(index).avatar!),
                        backgroundColor: Colors.red.shade800,
                      ),
                    ),
                  ),
                ),
                Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list.elementAt(index).name!,
                          style: GoogleFonts.pacifico(
                            textStyle: TextStyle(
                              color: Colors.blue,
                              letterSpacing: .5,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          list.elementAt(index).uTime!.toString(),
                          style: GoogleFonts.satisfy(
                            textStyle: TextStyle(
                              color: Colors.red,
                              letterSpacing: .5,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        );
      },
      itemCount: list.length,
    );
  }
}
