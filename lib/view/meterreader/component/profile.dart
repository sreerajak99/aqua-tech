import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateofbirthController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  File? imageFile;
  String? imageUrl;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (imageFile == null) return;

    final userId = auth.currentUser?.uid;
    if (userId == null) return;

    try {
      final ref = storage.ref().child('user_images').child('$userId.jpg');
      await ref.putFile(imageFile!);
      final url = await ref.getDownloadURL();

      await firestore.collection('usersprofile').doc(userId).update({'imageUrl': url});

      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Profile',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () async {
              setState(() {
                if (isEditing) {
                  saveUserData();
                  if (imageFile != null) {
                    _uploadImage();
                  }
                }
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: firestore.collection('usersprofile').doc(auth.currentUser?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No user data found'));
          }

          Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;

          nameController.text = userData['name'] ?? '';
          bioController.text = userData['address'] ?? '';
          dateofbirthController.text = userData['dateOfBirth'] ?? '';
          phonenumberController.text = userData['phoneNumber'] ?? '';
          emailController.text = userData['email'] ?? '';
          imageUrl = userData['imageUrl'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: isEditing ? pickImage : null,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: imageFile != null
                          ? FileImage(imageFile!)
                          : (imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : AssetImage("assetimage/307ce493-b254-4b2d-8ba4-d12c080d6651.jpg")) as ImageProvider,
                      child: isEditing
                          ? Icon(Icons.camera_alt, color: Colors.white70)
                          : null,
                    ),
                  ),
                  SizedBox(height: 16),
                  buildTextField(nameController, 'Name', 'Name'),
                  SizedBox(height: 16),
                  buildTextField(bioController, 'Address', 'Address'),
                  SizedBox(height: 16),
                  buildTextField(dateofbirthController, 'Date Of Birth', 'Date Of Birth'),
                  SizedBox(height: 16),
                  buildTextField(phonenumberController, 'Phone Number','Phone Number'),
                  SizedBox(height: 16),
                  buildTextField(emailController, 'Email Address', 'Email Address'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint, String label) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 3),
        TextField(
          controller: controller,
          enabled: isEditing,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),

            hintText: hint,
          ),
        ),
      ],
    );
  }

  void saveUserData() async {
    String userId = auth.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      await firestore.collection('usersprofile').doc(userId).set({
        'name': nameController.text,
        'address': bioController.text,
        'dateOfBirth': dateofbirthController.text,
        'phoneNumber': phonenumberController.text,
        'email': emailController.text,
      }, SetOptions(merge: true));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }
}