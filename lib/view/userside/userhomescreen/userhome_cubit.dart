import 'package:aquatech/view/userside/userhomescreen/userhomescreen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'userhome_state.dart';

class UserhomeCubit extends Cubit<UserhomeState> {
  UserhomeCubit(this.Userhomecontext) : super(UserhomeInitial());
  BuildContext Userhomecontext;
  int count = 0;
  TextEditingController name= TextEditingController();
  TextEditingController consumerid = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController description = TextEditingController();
  final FirebaseFirestore firesotre = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userName = "profile";
  history() {
    count = 0;
    emit(UserhomeInitial());
  }

  bill() {
    count = 1;
    emit(UserhomeInitial());
  }

  complints() {
    count = 2;
    emit(UserhomeInitial());
  }

  complaintStore() async {
    await firesotre
        .collection("Users")
        .doc(auth.currentUser!.uid.toString())
        .collection("complaint")
        .add({
      "subject": subject.text,
      "complaints": description.text,
      'name':name.text,
      'address':adress.text,
      'consumerid':consumerid.text,
      "Date": FieldValue.serverTimestamp(),
    });
    emit(UserhomeInitial());
  }

  popup(String head,String title) {
    showDialog(
      context: Userhomecontext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(head),
          content: Text(title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the pop-up
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
 
}
