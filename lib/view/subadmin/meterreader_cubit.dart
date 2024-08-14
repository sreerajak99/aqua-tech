import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'meterreader_state.dart';

class SubadminCubit extends Cubit<SubadminState> {
  SubadminCubit( this.metercontext) : super(SubadminInitial());
  BuildContext metercontext;
  final TextEditingController emailctr = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController ConformPassword = TextEditingController();
  final TextEditingController Name = TextEditingController();
  final TextEditingController Surname = TextEditingController();
  final TextEditingController meterreaderid = TextEditingController();
  FirebaseAuth auth= FirebaseAuth.instance;

  Future<void> MetrereaderRegister() async {
    if (emailctr.text.isEmpty || password.text.isEmpty) {
      showErrorMessage("Email and password cannot be empty");
      return;
    }

    if (password.text != ConformPassword.text) {
      showErrorMessage("Passwords do not match");
      return;
    }

    try {
      await auth
          .createUserWithEmailAndPassword(
          email: emailctr.text.trim(), password: password.text.trim())
          .then((value) { postdetailsFirebase();showSuccessMessage('registration Successfull');

      });

    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred during registration";
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      showErrorMessage(errorMessage);
    } catch (e) {
      showErrorMessage("An unexpected error occurred");
      print(e);
    }
  }


  postdetailsFirebase() async {
    var user = auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('Userlist');
    SubadminEntity userEntity = SubadminEntity(
        email: emailctr.text,
        name: Name.text,
        rool: "meterreader",
        consumerid: meterreaderid.text);
    ref.doc(user!.uid).set(userEntity.toJson());
  }
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(metercontext).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(metercontext).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }
  clrearFunction(){
    emailctr.clear();
    password.clear();
    Name.clear();
    ConformPassword.clear();
    Surname.clear();
    meterreaderid.clear();

  }

}

class SubadminEntity {
  final String? userId;
  final String email;
  final String name;
  final String rool;
  final String consumerid;

  SubadminEntity(
      {this.userId,
        required this.email,
        required this.name,
        required this.rool,
        required this.consumerid});

  factory SubadminEntity.fromJson(Map<String, dynamic> json,
      {required String id}) =>
      SubadminEntity(
        consumerid: json["consumerid"],
        email: json["email"],
        userId: id,
        name: json["name"],
        rool: json["rool"],
      );

  Map<String, dynamic> toJson() =>
      {"email": email, "name": name, "rool": rool, "consumerid": consumerid};
}
