import 'package:aquatech/view/meterreader/meterreader_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillRegisterForm extends StatelessWidget {
  BillRegisterForm({
    Key? key,
  }) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 600,
          width: 360,
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: BlocProvider(
                create: (context) => MeterreaderCubit(context),
                child: BlocBuilder<MeterreaderCubit, MeterreaderState>(
                  builder: (context, state) {
                    final meter = context.read<MeterreaderCubit>();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bill Registration',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: meter.consumeridController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Consumer ID',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter previous reading';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: meter.previousReadingController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Previous Reading',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter previous reading';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: meter.currentReadingController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Current Reading',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter current reading';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              meter.postfiredata();
                              meter.previousReadingController.clear();
                              meter.currentReadingController.clear();
                              meter.consumerNameController.clear();
                              meter.consumerAddressController.clear();
                              meter.consumeridController.clear();
                              meter.popup("Registration", "Successfull");
                            }
                          },
                          child: const Text('Register Bill'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.lightBlueAccent),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
