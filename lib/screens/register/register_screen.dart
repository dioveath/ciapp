import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class RegisterScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
