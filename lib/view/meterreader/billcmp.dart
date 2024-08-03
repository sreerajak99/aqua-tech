import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BillRegisterForm extends StatelessWidget {
  BillRegisterForm(
      {Key? key,
        required this.Onpressed,
      required this.currentReadingController,
      required this.previousReadingController,
      required this.consumerAddressController,
      required this.consumeridController,
      required this.consumerNameController})
      : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController consumerNameController;

  final TextEditingController consumeridController;

  final TextEditingController consumerAddressController;
  final TextEditingController previousReadingController;

  final TextEditingController currentReadingController;
final VoidCallback Onpressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 600,
          width: 360,
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bill Registration',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: consumerNameController,
                    decoration: const InputDecoration(
                      labelText: 'Consumer Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter consumer name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: consumeridController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Consumer ID',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter previous reading';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: consumerAddressController,
                    decoration: const InputDecoration(
                      labelText: 'Consumer Address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter consumer address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: previousReadingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Previous Reading',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter previous reading';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: currentReadingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Current Reading',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current reading';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: Onpressed,
                    child: const Text('Register Bill'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
