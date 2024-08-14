import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/view/adminside/addsubadmin.dart';
import 'package:aquatech/view/adminside/admin_complaint_view_section.dart';
import 'package:aquatech/view/adminside/admin_cubit.dart';
import 'package:aquatech/view/adminside/adminbottambar.dart';
import 'package:aquatech/view/adminside/admindrawer.dart';
import 'package:aquatech/view/adminside/animatedadmincontainer.dart';
import 'package:aquatech/view/adminside/listswipe.dart';
import 'package:aquatech/view/adminside/userlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHome extends StatelessWidget {
  AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlueAccent, Colors.white, Colors.white])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: AppText(
                  teXt: "Aqua Tech",
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            toolbarHeight: 100,
          ),
          drawer: DrawercontenT(name: "Admin"),
          body: BlocProvider(
            create: (context) => AdminCubit(context),
            child: BlocBuilder<AdminCubit, AdminState>(
              builder: (context, state) {
                final cubitadmin = context.read<AdminCubit>();

                return Column(children: [
                  Expanded(
                      flex: 9,
                      child: countUniversal == 0
                          ? UserAndMeterReaderList()
                          : countUniversal == 1
                              ? AddSubAdmin(
                                  password: cubitadmin.password,
                                  emailctr: cubitadmin.emailctr,
                                  conformpassword: cubitadmin.ConformPassword,
                                  Name: cubitadmin.Name,
                                  SubadminId: cubitadmin.SubadminId,
                                  Surname: cubitadmin.Surname,
                                  Onpressed: () {
                                    cubitadmin.Subadminnregister();

                                    cubitadmin.ConformPassword.clear();
                                    cubitadmin.password.clear();
                                    cubitadmin.emailctr.clear();
                                    cubitadmin.SubadminId.clear();
                                    cubitadmin.Surname.clear();
                                    cubitadmin.Name.clear();
                                  },
                                )
                              : AdminComplaintsScreen()),
                  Center(
                    child: Column(
                      children: [
                        BottambarAdmin(
                          count: cubitadmin.count,
                          Onpresshome: () {
                            cubitadmin.home();
                            countUniversal = cubitadmin.count;
                          },
                          Onpressmessage: () {
                            cubitadmin.message();
                            countUniversal = cubitadmin.count;
                          },
                          Onpressuser: () {
                            cubitadmin.user();
                            countUniversal = cubitadmin.count;
                          },
                        )
                      ],
                    ),
                  )

                ]);
              },
            ),
          ),

        ));
  }
}
