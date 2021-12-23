
import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:ciapp/shared/input_decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'ci_button.dart';

final _formUserDetailKey = GlobalKey<FormState>();

class UserDetailsForm extends StatelessWidget {
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var ci_user = context.watch<CIUser>();

    var user = context.watch<User>();

    var ciDefault = new CIUser(
      doc_id: "DOC_ID",
      first_name: "Santosh",
      last_name: "Adhikari",
      rank: "CFO",
      exp_points: 1380,
      level: 18,
      roles: {},
    );

    debugPrint("Widget rebuilding");

    firstNameEditingController.text = ci_user.first_name;
    lastNameEditingController.text = ci_user.last_name;
    phoneNumberEditingController.text = ci_user.phone_number.toString();
    addressEditingController.text = ci_user.address;

    return Container(
      child: Form(
        key: _formUserDetailKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: TextFormField(
                  controller: firstNameEditingController
                    ..text = ci_user.first_name,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: getInputDecoration("First Name", Icons.person),
                ),
              ),
              SizedBox(height: 14), 
              Container(
                child: TextFormField(
                  controller: lastNameEditingController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: getInputDecoration("Last Name", Icons.people),
                ),
              ),
              SizedBox(height: 14), 
              Container(
                child: TextFormField(
                  controller: phoneNumberEditingController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration: getInputDecoration("Phone Number", Icons.phone),
                ),
              ),
              SizedBox(height: 14), 
              Container(
                child: TextFormField(
                  controller: addressEditingController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value.isEmpty) return "Empty";
                    return "";
                  },
                  onChanged: (value) {},
                  decoration: getInputDecoration("Address", Icons.place),
                ),
              ),
              SizedBox(height: 24), 
              CIButton(
                  text: "Save",
                  onTap: () {
                    _formUserDetailKey.currentState.validate();
                    ci_user.first_name = firstNameEditingController.text;
                    ci_user.last_name = lastNameEditingController.text;
                    ci_user.phone_number =
                        int.parse(phoneNumberEditingController.text);
                    ci_user.address = addressEditingController.text;

                    DatabaseService().updateCIUser(ci_user);
                    Navigator.pop(context);
                  }),
              SizedBox(height: 14), 
              CIButton(
                  text: "Cancel",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  positiveButton: false),
              SizedBox(height: 6), 
            ]),
      ),
    );
  }
}

