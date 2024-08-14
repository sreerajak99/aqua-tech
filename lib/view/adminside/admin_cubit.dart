import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit(this.admincontext) : super(AdminInitial());
  BuildContext admincontext;
  int count = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firedata = FirebaseFirestore.instance;
  final TextEditingController emailctr = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController ConformPassword = TextEditingController();
  final TextEditingController Name = TextEditingController();
  final TextEditingController Surname = TextEditingController();
  final TextEditingController SubadminId = TextEditingController();

  home() {
    count = 1;
    emit(AdminInitial());
  }

  message() {
    count = 2;
    emit(AdminInitial());
  }

  user() {
    count = 0;
    emit(AdminInitial());
  }


  Future<void> Subadminnregister() async {
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
        rool: "subadmin",
        consumerid: SubadminId.text);
    ref.doc(user!.uid).set(userEntity.toJson());
  }
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(admincontext).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(admincontext).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
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
