import 'package:ci_ui/ci_ui.dart';
import 'package:ciapp/screens/register/register_screen.dart';
import 'package:ciapp/service/authentication_service.dart';
import 'package:ciapp/constants.dart';
import 'package:ciapp/shared/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String phone;
  String password;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  bool remember = false;

  final List<String> errors = [];

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(color: kPrimaryColor, width: 1),
          bottom: BorderSide(color: kPrimaryColor, width: 1), 
        ),
      ),
      padding: EdgeInsets.only(top: 14, bottom: 12),
      child: Form(
        key: _formKey,
        child: Column(children: [
          buildEmailField(),
          verticalSpacerMedium,
          buildPasswordField(),
          verticalSpacerMedium,
          Container(
            child: Column(
              children: List.generate(
                  errors.length, (index) => FormErrorText(text: errors[index])),
            ),
          ),
          verticalSpacerMedium,
          loading
              ? Container(
                  alignment: Alignment.bottomCenter,
                  child:
                      CircularProgressIndicator(backgroundColor: kPrimaryColor))
              : CIButton(title: "LOGIN", onTap: onPressed),
          verticalSpacerMedium,
          CIButton(
              title: "REGISTER",
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              }),
        ]),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPasswordEmptyError)) {
          setState(() {
            errors.remove(kPasswordEmptyError);
          });
        } else if (!(value.length < 6) &&
            errors.contains(kPasswordInvalidError)) {
          setState(() {
            errors.remove(kPasswordInvalidError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kPasswordEmptyError))
            setState(() {
              errors.add(kPasswordEmptyError);
            });
          // return kPasswordEmptyError;
        } else if (value.length < 6 &&
            !errors.contains(kPasswordInvalidError)) {
          setState(() {
            errors.add(kPasswordInvalidError);
          });
          // return kPasswordInvalidError;
        }
      },
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
      decoration: getInputDecoration("Password", Icons.lock),
    );
  }

  TextFormField buildPhoneNumberField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPhoneEmptyError)) {
          setState(() {
            errors.remove(kPhoneEmptyError);
          });
        } else if (!(value.length < 10) &&
            errors.contains(kPhoneInvalidError)) {
          setState(() {
            errors.remove(kPhoneInvalidError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kPhoneEmptyError))
            setState(() {
              errors.add(kPhoneEmptyError);
            });
        } else if (value.length < 10 && !errors.contains(kPhoneInvalidError)) {
          setState(() {
            errors.add(kPhoneInvalidError);
          });
        }
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Phone Number",
        // labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.phone_android),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: emailController,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailEmptyError)) {
          setState(() {
            errors.remove(kEmailEmptyError);
          });
        } else if (!(value.length <= 10) &&
            errors.contains(kEmailInvalidError)) {
          setState(() {
            errors.remove(kEmailInvalidError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kEmailEmptyError))
            setState(() {
              errors.add(kEmailEmptyError);
            });
          // return kEmailEmptyError;
        } else if ((value.length <= 10) &&
            !errors.contains(kEmailInvalidError)) {
          setState(() {
            errors.add(kEmailInvalidError);
          });
          // return kEmailInvalidError;
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: getInputDecoration("Email Address", Icons.email),
    );
  }

  void onPressed() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      _formKey.currentState.save();

      debugPrint(emailController.text);
      debugPrint(passwordController.text);

      dynamic result =
          await Provider.of<AuthenticationService>(context, listen: false)
              .signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (result.toString() != "Signed In") {
        setState(() {
          if (!errors.contains(kPasswordIncorrectError))
            errors.add(kPasswordIncorrectError);
        });
      }

      setState(() {
        loading = false;
      });
    } else {
      debugPrint("validation failed!");
    }
  }
} // end of class

class FormErrorText extends StatelessWidget {
  final String text;

  const FormErrorText({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return FittedBox(
    // fit: BoxFit.fitWidth,
    // child:
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(Icons.error, color: Colors.red),
      SizedBox(width: 4),
      Expanded(
        child: Text(text,
            maxLines: 4,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.normal,
                fontSize: 12)),
      ),
    ]);
  }
}
