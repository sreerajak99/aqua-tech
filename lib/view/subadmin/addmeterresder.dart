import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/view/adminside/adminformfield.dart';
import 'package:aquatech/view/subadmin/meterreader_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMeterReader extends StatelessWidget {
  const AddMeterReader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          "Add Meter Reader",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
  create: (context) => SubadminCubit(context),
  child: BlocBuilder<SubadminCubit, SubadminState>(
          builder: (context, state) {
            final meter =context.read<SubadminCubit>();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: AppText(
                    teXt: "",
                    color: Colors.black,
                    size: 15,
                  ),
                ),
                Center(
                  child: Container(
                    height: 500,
                    width: 370,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.lightBlueAccent]),
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(3, 3))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90, left: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              AdminFormfield(keyboardType: TextInputType.text,
                                  hintText: "Name",
                                  controller: meter.Name,
                                  widtH: 150),
                              SizedBox(
                                width: 10,
                              ),
                              AdminFormfield(
                                keyboardType: TextInputType.text,
                                  hintText: "surname(optional)",
                                  controller: meter.Surname,
                                  widtH: 180),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, right: 10),
                            child: AdminFormfield(
                              keyboardType: TextInputType.number,
                                hintText: "Meter Reader ID",
                                controller: meter.meterreaderid,
                                widtH: 340),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, right: 10),
                            child: AdminFormfield(
                              keyboardType: TextInputType.emailAddress,
                                hintText: "Email ",
                                controller: meter.emailctr,
                                widtH: 340),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, right: 10),
                            child: AdminFormfield(
                              keyboardType: TextInputType.number,
                                hintText: "Password",
                                controller: meter.password,
                                widtH: 340),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, right: 10),
                            child: AdminFormfield(
                              keyboardType: TextInputType.number,
                                hintText: "Conform Password",
                                controller: meter.ConformPassword,
                                widtH: 340),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {meter.MetrereaderRegister();
                    meter.clrearFunction();},
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                        child: AppText(
                          teXt: "Submit",
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            );
          },
        ),
),
      ),
    );
  }
}
