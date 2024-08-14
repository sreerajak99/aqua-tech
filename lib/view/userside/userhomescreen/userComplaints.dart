import 'package:aquatech/view/userside/userhomescreen/userhome_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final formKey = GlobalKey<FormState>();
  String subject = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File a Complaint'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: BlocProvider(
            create: (context) => UserhomeCubit(context),
            child: BlocBuilder<UserhomeCubit, UserhomeState>(
              builder: (context, state) {
                final complaint = context.read<UserhomeCubit>();
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: complaint.name,
                        decoration: InputDecoration(
                          hintText: 'Consumer Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Consumer Name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          subject = value!;
                        },
                      ),
                      SizedBox(height: 16.0,),
                      TextFormField(
                        controller: complaint.consumerid,
                        decoration: InputDecoration(
                          hintText: 'Consumer ID',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Consumer ID';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          subject = value!;
                        },
                      ),
                      SizedBox(height: 16.0,),
                      TextFormField(
                        controller: complaint.adress,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Place Details';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          subject = value!;
                        },
                      ),
                      SizedBox(height: 16.0,),
                      TextFormField(
                        controller: complaint.subject,
                        decoration: InputDecoration(
                          hintText: 'Subject',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a subject';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          subject = value!;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: complaint.description,
                        decoration: InputDecoration(
                          hintText: 'Complaint Description',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          description = value!;
                        },
                      ),
                      SizedBox(height: 24.0),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.lightBlueAccent)),
                        child: Text(
                          'Submit Complaint',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            complaint.complaintStore();
                            complaint.description.clear();
                            complaint.subject.clear();
                            complaint.name.clear();
                            complaint.consumerid.clear();
                            complaint.adress.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Complaint submitted successfully')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
