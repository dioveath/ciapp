import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:flutter/material.dart';


class ProfileViewDetails extends StatelessWidget {
  CIUser ciUser;

  ProfileViewDetails(this.ciUser);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kBackgroundColor,
      child: Column(
        children: [

        ],
      ),
    );
  }
}
