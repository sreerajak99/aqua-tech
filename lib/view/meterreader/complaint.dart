import 'package:aquatech/view/meterreader/meterreader_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintRegistrationForm extends StatelessWidget {
  ComplaintRegistrationForm({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => MeterreaderCubit(context),
          child: BlocBuilder<MeterreaderCubit, MeterreaderState>(
            builder: (context, state) {
              final meter = context.read<MeterreaderCubit>();
              return Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100, left: 15),
                      child: Text(
                        'Complaint Registration',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        image: DecorationImage(
                            image: AssetImage("assetimage/9465754.png"))),
                  ),
                  Container(
                    height: 600,
                    width: 360,
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20.0),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: meter.consumerNameController,
                              decoration: const InputDecoration(
                                hintText: 'Consumer Name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent))
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter consumer name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              keyboardType:  TextInputType.number,
                              controller: meter.consumeridController,
                              decoration: const InputDecoration(
                                hintText: 'Consumer ID',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent))
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter consumer ID';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: meter.consumerAddressController,
                              decoration: const InputDecoration(
                                hintText: 'Consumer Address',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent))
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter consumer address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: meter.complaintcontroller,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                hintText: 'Complaint Description',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent))
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a complaint description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.lightBlueAccent),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  meter.complaintMeterreader();
                                  meter.complaintcontroller.clear();
                                  meter.consumerAddressController.clear();
                                  meter.consumeridController.clear();
                                  meter.consumerNameController.clear();
                                  meter.popup("Complaint", "registration Successfull");
                                }
                              },
                              child: const Text('Register Complaint'),
                            ),
                          ],
                        ),
                      ),
                    ),
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
