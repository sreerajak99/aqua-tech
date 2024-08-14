import 'package:aquatech/view/Loginregister/LoginRegisterSwitchButton.dart';
import 'package:aquatech/view/Loginregister/loginsection.dart';
import 'package:aquatech/components/mytextfield.dart';
import 'package:aquatech/view/Loginregister/registersection.dart';
import 'package:aquatech/components/stackcmp.dart';
import 'package:aquatech/view/Loginregister/loginregister_cubit.dart';
import 'package:aquatech/view/userside/userhomescreen/userhomescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loginorregister extends StatelessWidget {
  const Loginorregister({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginregisterCubit(context),
      child: BlocBuilder<LoginregisterCubit, LoginregisterState>(
        builder: (context, state) {
          final cubitloginregister = context.read<LoginregisterCubit>();
          return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.lightBlue, Colors.white])),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: BlocProvider(
                  create: (context) => LoginregisterCubit(context),
                  child: BlocBuilder<LoginregisterCubit, LoginregisterState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            flag == true
                                ? Loginsection(
                                    username: cubitloginregister.name,
                                    password: cubitloginregister.password,
                                    email: cubitloginregister.emailctr,
                                    Ontap: () {
                                      cubitloginregister.login();
                                    },
                                  )
                                : REgisterSection(
                                    email: cubitloginregister.emailctr,
                                    password: cubitloginregister.password,
                                    conformpassword:
                                        cubitloginregister.conformpassword,
                                    consumerid: cubitloginregister.consumerid,
                                    name: cubitloginregister.name,
                                    Ontap: () {
                                      cubitloginregister.register();
                                    },
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ));
        },
      ),
    );
  }
}
