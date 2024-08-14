import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/view/meterreader/billcmp.dart';
import 'package:aquatech/view/meterreader/meterreader_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewBillmeterreadder extends StatelessWidget {
  NewBillmeterreadder({super.key});

  FirebaseFirestore firedata = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => MeterreaderCubit(context),
          child: BlocBuilder<MeterreaderCubit, MeterreaderState>(
            builder: (context, state) {
              final cubitmeter = context.read<MeterreaderCubit>();
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16)),
                      image: DecorationImage(
                          image:
                              AssetImage("assetimage/3d-water-ai-generate.jpg"),
                          fit: BoxFit.fill),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, top: 190),
                      child: AppText(
                        teXt: "Aqua Tech",
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BillRegisterForm()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
