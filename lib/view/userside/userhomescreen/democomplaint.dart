import 'package:aquatech/view/userside/userhomescreen/userhome_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserComplaintS extends StatelessWidget {
  const UserComplaintS({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final desiredHeight = screenHeight * (610 / 812);
    final desiredWidth = screenWidth * (360 / 375);
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => UserhomeCubit(context),
        child: BlocBuilder<UserhomeCubit, UserhomeState>(
          builder: (context, state) {
            final user = context.read<UserhomeCubit>();
            return Column(children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  height: desiredHeight,
                  width: desiredWidth,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Complaint Form',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const Text('Subject:'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: user.subject,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: 'Enter the subject of your complaint',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Description:'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: user.description,
                          maxLines: 9,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: 'Describe your complaint in detail',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        TextFormField(),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.lightBlueAccent)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              user.complaintStore();
                              user.description.clear();
                              user.subject.clear();
                              user.popup("Complaint", "Successful");
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]);
          },
        ),
      ),
    );
  }
}
