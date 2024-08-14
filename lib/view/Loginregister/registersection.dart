import 'package:aquatech/components/mytextfield.dart';

import 'package:aquatech/view/Loginregister/consumeridField.dart';
import 'package:aquatech/view/Loginregister/emailvalidatetextfield.dart';
import 'package:aquatech/view/Loginregister/loginregister_cubit.dart';
import 'package:aquatech/view/Loginregister/passwordTextfield.dart';
import 'package:aquatech/view/Loginregister/phonetextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class REgisterSection extends StatelessWidget {
  final VoidCallback? Ontap;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController name;
  final TextEditingController consumerid;
  final TextEditingController conformpassword;
  final formKey = GlobalKey<FormState>();

  REgisterSection(
      {super.key,
      this.Ontap,
      required this.email,
      required this.password,
      required this.conformpassword,
      required this.name,
      required this.consumerid});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 390,
          height: 390,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assetimage/—Pngtree—water water ripple water droplets_3800343.png"),
                  fit: BoxFit.fill)),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Form(
              key: formKey,
              child: BlocProvider(
                create: (context) => LoginregisterCubit(context),
                child: BlocBuilder<LoginregisterCubit, LoginregisterState>(
                  builder: (context, state) {
                    final register = context.read<LoginregisterCubit>();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Create a Account for you",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 3, left: 50, top: 5),
                              child: MyTextFormField(
                                  widtH: 140,
                                  suffixIcon: CupertinoIcons.person,
                                  hintText: "User Name",
                                  warning: "enter user name",
                                  controller: register.name),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(right: 25, top: 5),
                                child: MyconsumerField(
                                    hintText: "consumer ID",
                                    warning: "fill this",
                                    controller: register.consumerid,
                                    widtH: 140)),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 5),
                            child: EmailTextField(
                                hintText: "Email",
                                controller: register.emailctr,
                                width: 299)),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 5),
                            child: MyPhoneField(
                                hintText: "Mobile Number",
                                controller: register.mobilenumber,
                                width: 300)),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 5),
                            child: MyPasswordField(
                                hintText: "Enter A Password",
                                controller: register.password,
                                width: 300)),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                final consumerId = register.consumerid.text;
                                final usermail=register.emailctr.text;
                                final userconsumerid = await FirebaseFirestore.instance
                                    .collection('user_data_entrol')
                                    .where('ConsumerId', isEqualTo: consumerId)
                                    .get();
                                final useremail = await FirebaseFirestore.instance
                                    .collection('user_data_entrol')
                                    .where('email', isEqualTo:usermail )
                                    .get();

                                if (userconsumerid.docs.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Consumer ID is Not Found',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),

                                  );

                                } else if(useremail.docs.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Email is not verified',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),

                                  );
                                }else {
                                  register.register();
                                }
                              }
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.lightBlueAccent.shade100,
                                    Colors.white,
                                    Colors.lightBlueAccent.shade100
                                  ]),
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            )),
      ],
    );
  }
}
