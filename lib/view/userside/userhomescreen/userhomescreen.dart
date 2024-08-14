import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/components/bottambar%20component/myanimatedcontainer.dart';
import 'package:aquatech/view/userside/components/drawer.dart';
import 'package:aquatech/view/userside/userhomescreen/userComplaints.dart';
import 'package:aquatech/view/userside/userhomescreen/userHistory.dart';
import 'package:aquatech/view/userside/userhomescreen/userbill.dart';
import 'package:aquatech/view/userside/userhomescreen/userhome_cubit.dart';
import 'package:aquatech/view/userside/userhomescreen/usernewbill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({super.key, required this.name,required this.consumerId});
  final String name;
final String consumerId;

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int count = 1;

  final focusNodeHistory = FocusNode();

  final focusNodeBill = FocusNode();

  final focusNodeComplaints = FocusNode();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.lightBlue, Colors.white],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Hi consumer",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenSize.width * 0.045,
              color: Colors.white,
            ),
          ),
        ),
        drawer: Drawercontent(name: widget.name),
        body: BlocProvider(
          create: (context) => UserhomeCubit(context),
          child: BlocBuilder<UserhomeCubit, UserhomeState>(
            builder: (context, state) {
              final cubitData = context.read<UserhomeCubit>();

              return Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: count == 0
                        ? Userhistory(consumerId: widget.consumerId,)
                        : count == 1
                        ? BillPage(consumerId: widget.consumerId)
                        : ComplaintScreen(),
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.lightBlueAccent),
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.all(Radius.circular(16)),
                                    ),
                                    width: screenSize.width * 0.83,
                                    height: screenSize.height * 0.07,
                                    child: Row(
                                      children: [
                                        SizedBox(width: screenSize.width*0.01,),
                                        InkWell(
                                          focusNode: focusNodeHistory ,
                                          onTap: () {

                                            cubitData.history();
                                            count = cubitData.count;
                                          },
                                          child: AppAnimatedContainer(
                                            containercolordata: count == 0 ? Colors.white : Colors.lightBlueAccent,
                                            heighT: screenSize.height*0.06,
                                            icondata: Icon(Icons.history),
                                            wIdth: count == 0 ? screenSize.width * 0.30 : screenSize.width * 0.25,
                                            textSize: screenSize.width * 0.04,
                                            teXtdATA: "History",
                                          ),
                                        ),
                                        InkWell(
                                          focusNode: focusNodeBill,
                                          onTap: () {
                                            cubitData.bill();
                                            count = cubitData.count;
                                          },
                                          child: AppAnimatedContainer(
                                            containercolordata: count == 1 ? Colors.white : Colors.lightBlueAccent,
                                            icondata: Icon(Icons.receipt),
                                            wIdth: count == 1 ? screenSize.width * 0.30: screenSize.width * 0.25,
                                            heighT: screenSize.height*0.06,
                                            textSize: screenSize.width * 0.04,
                                            teXtdATA: "Bill",
                                          ),
                                        ),
                                        InkWell(
                                          focusNode: focusNodeComplaints,
                                          onTap: () {
                                            cubitData.complints();
                                            count = cubitData.count;
                                          },
                                          child: AppAnimatedContainer(
                                            containercolordata: count == 2 ? Colors.white : Colors.lightBlueAccent,
                                            icondata: Icon(Icons.inbox),
                                            wIdth: count == 2 ? screenSize.width * 0.30 : screenSize.width * 0.25,
                                            heighT: screenSize.height*0.06,
                                            textSize: screenSize.width * 0.04,
                                            teXtdATA: "Complaints",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}