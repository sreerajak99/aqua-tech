import 'package:aquatech/view/adminside/adminhomefirstpage.dart';
import 'package:aquatech/view/adminside/adminhomescreen.dart';
import 'package:aquatech/view/meterreader/meterreader_homescreen.dart';
import 'package:aquatech/view/subadmin/subadminhoomescreen.dart';
import 'package:aquatech/view/userside/userhomescreen/userhomescreen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Flutter 3.19.6
part 'loginregister_state.dart';

class LoginregisterCubit extends Cubit<LoginregisterState> {
  LoginregisterCubit(this.loginregistercontext) : super(LoginregisterInitial());
  BuildContext loginregistercontext;
  TextEditingController emailctr = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController conformpassword = TextEditingController();
  TextEditingController consumerid = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firedata = FirebaseFirestore.instance;

  login() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: emailctr.text.trim(), password: password.text.trim())
          .then((value) => root(user: auth.currentUser));
    } catch (e) {
      ScaffoldMessenger.of(loginregistercontext)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print("$e>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    }
  }

  register() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: emailctr.text.trim(), password: password.text.trim())
          .then((value) { postdetailsFirebase(); billdata();});
    } catch (e) {
      ScaffoldMessenger.of(loginregistercontext)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
    }
  }

  postdetailsFirebase() async {
    var user = auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('Userlist');
    UserEntity userEntity = UserEntity(
        email: emailctr.text,
        name: name.text,
        rool: "user",
        consumerid: consumerid.text);
    ref.doc(user!.uid).set(userEntity.toJson());
    root(user: user);
  }

  root({User? user}) async {
    await firebaseFirestore.collection("Userlist").doc(user!.uid).get().then(
      (value) {
        if (value.exists) {
          switch (value.get("rool")) {
            case "admin":
              if (ConnectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                Navigator.of(loginregistercontext).push(MaterialPageRoute(
                  builder: (context) => AdminhomeFirstPage(),
                ));
              }
              break;
            case "subadmin":
              if (ConnectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                Navigator.of(loginregistercontext).push(MaterialPageRoute(
                  builder: (context) => SubadminHomescreen(),
                ));
              }
              break;
            case "user":
              if (ConnectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                Navigator.of(loginregistercontext).push(MaterialPageRoute(
                  builder: (context) => UserHomeScreen(
                    consumerId: value.get("consumerid"),
                    name: value.get('name'),
                  ),
                ));
              }
              break;
            case "meterreader":
              if (ConnectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                Navigator.of(loginregistercontext).push(MaterialPageRoute(
                  builder: (context) => MeterReaderHome(),
                ));
              }
          }
        }
      },
    );
  }

  billdata() {
    FirebaseFirestore.instance
        .collection("bll store")
        .doc(consumerid.text)
        .collection("bill")
        .add({
      "consumerName": "",
      "consumerID": "",
      "consumerAdress": "",
      "previousreading": "",
      "currentreading": "",
      "created": "",
      "usage": "",
      "amount": "",
    });
  }
}

class UserEntity {
  final String? userId;
  final String email;
  final String name;
  final String rool;
  final String consumerid;

  UserEntity(
      {this.userId,
      required this.email,
      required this.name,
      required this.rool,
      required this.consumerid});

  factory UserEntity.fromJson(Map<String, dynamic> json,
          {required String id}) =>
      UserEntity(
        consumerid: json["consumerid"],
        email: json["email"],
        userId: id,
        name: json["name"],
        rool: json["rool"],
      );

  Map<String, dynamic> toJson() =>
      {"email": email, "name": name, "rool": rool, "consumerid": consumerid};
}
