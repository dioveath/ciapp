import 'package:ciapp/constants.dart';
import 'package:ciapp/screens/dashboard/components/profile/profile_head.dart';
import 'package:ciapp/screens/dashboard/components/profile/profile_userform.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'body.dart';

// final _profileScaffoldKey = GlobalKey<ScaffoldState>();

class ProfileScreen extends StatelessWidget {
  static final String routeName = '/profile';

  var userDetailForm = UserDetailsForm();
  var profileHead = ProfileHead();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    debugPrint("ProfileScreen rebuilding");

    return MultiProvider(
      providers: [
        Provider<UserDetailsForm>.value(
          value: userDetailForm,
        ),
        Provider<ProfileHead>.value(
          value: profileHead,
        ),
      ],
      child: Scaffold(
        body: Body(),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          toolbarHeight: 0,
        ),
      ),
    );
  }
}
