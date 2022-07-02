import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:ciapp/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profileview_body.dart';

class ProfileViewScreen extends StatelessWidget {
  String? uid;
  ProfileViewScreen(this.uid);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var authUser = context.watch<User>();
    return Scaffold(
      body: FutureBuilder<Object>(
          future: DatabaseService().getCIUser(uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(child: CircularProgressIndicator());
            CIUser ciUser = snapshot.data as CIUser;
            if (ciUser.doc_id != authUser.uid && ciUser.profileVisits != null) {
              ciUser.profileVisits = ciUser.profileVisits! + 1;
              ciUser.exp_points = ciUser.exp_points! + 1;
              DatabaseService().updateCIUser(ciUser);
            }
            return ProfileViewBody(ciUser);
          }),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        toolbarHeight: 0,
      ),
    );
  }
}
