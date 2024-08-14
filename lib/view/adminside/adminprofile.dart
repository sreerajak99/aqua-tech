import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminProfilePage extends StatefulWidget {
  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  bool isEditing = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateofbirthController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? _imageFile;
  String? _imageUrl;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    try {
      final ref = _storage.ref().child('user_images').child('$userId.jpg');
      await ref.putFile(_imageFile!);
      final url = await ref.getDownloadURL();

      await _firestore.collection('usersprofile').doc(userId).update({'imageUrl': url});

      setState(() {
        _imageUrl = url;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () async {
              setState(() {
                if (isEditing) {
                  saveUserData();
                  if (_imageFile != null) {
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
        stream: _firestore.collection('usersprofile').doc(_auth.currentUser?.uid).snapshots(),
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
          _imageUrl = userData['imageUrl'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: isEditing ? _pickImage : null,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : (_imageUrl != null
                          ? NetworkImage(_imageUrl!)
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
    String userId = _auth.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      await _firestore.collection('usersprofile').doc(userId).set({
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