
import 'package:aquatech/view/adminside/adminhomefirstpage.dart';
import 'package:aquatech/view/adminside/adminhomescreen.dart';
import 'package:aquatech/view/begining/model.dart';
import 'package:aquatech/view/meterreader/meterreader_homescreen.dart';
import 'package:aquatech/view/subadmin/subadminhoomescreen.dart';
import 'package:aquatech/view/userside/userhomescreen/userhomescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aqua Tech',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.hasData ? FutureBuilder(
            future: getUserRole(),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return roleSnapshot.data ?? const Getstart();
            },
          ) : const Getstart();
        },
      ),
    );
  }
}

Future<Widget> getUserRole() async {
  DocumentSnapshot userDoc = await FirebaseFirestore.instance
      .collection("Userlist")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();

  if (userDoc.exists) {
    String role = userDoc.get("rool");
    switch (role) {
      case "admin":
        return AdminhomeFirstPage();
      case "subadmin":
        return SubadminHomescreen();
      case "user":
        return UserHomeScreen(
          consumerId: userDoc.get("consumerid"),
          name: "name",
        );
      case "meterreader":
        return MeterReaderHome();
      default:
        return const Getstart();
    }
  }
  return const Getstart();
}