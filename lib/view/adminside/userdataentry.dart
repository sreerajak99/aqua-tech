import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDataEntryPortal extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController Name = TextEditingController();

  final TextEditingController consumernumber = TextEditingController();

  final TextEditingController Address = TextEditingController();
  final TextEditingController emaidata = TextEditingController();
  List<String> keralaDicricts = [
    'Thiruvananthapuram',
    'Kollam',
    'Pathanamthitta',
    'Alappuzha',
    'Kottayam',
    'Idukki',
    'Ernakulam',
    'Thrissur',
    'Palakkad',
    'Malappuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Kasaragod',
  ];

  void showDistrictSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select District'),
          content: SingleChildScrollView(
            child: ListBody(
              children: keralaDicricts.map((String district) {
                return ListTile(
                  title: Text(district),
                  onTap: () {
                    Address.text = district;
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          'User Data Entry Portal',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: Name,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: consumernumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Consumer Number',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your consumer number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emaidata,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'email',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email id';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: Address,
                  readOnly: true, // Make the field read-only
                  onTap: () {
                    showDistrictSelector(context);
                  },
                  decoration: InputDecoration(
                    hintText: 'District',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid Details';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.lightBlueAccent)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection('user_data_entrol').doc(consumernumber.text)
                          .set({
                        "UserName": Name.text.trim(),
                        'ConsumerId': consumernumber.text.trim(),
                        'Address': Address.text.trim(),
                        'email':emaidata.text.trim()
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Registration Successfull',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.lightGreen,
                      ));
                      Name.clear();
                      consumernumber.clear();
                      Address.clear();
                      emaidata.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'complete the details',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
