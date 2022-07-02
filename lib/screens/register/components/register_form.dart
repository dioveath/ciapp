import 'package:ciapp/constants.dart';
import 'package:ciapp/service/authentication_service.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:ciapp/shared/input_decoration.dart';
import 'package:ciapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key key,
  }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _registerFormKey = GlobalKey<FormState>();
  String phone;
  String password;

  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();

  bool remember = false;

  final List<String> errors = [];

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Form(
        key: _registerFormKey,
        child: Column(
          children: [
            Image.asset("assets/images/ci_logo_alpha.png",
                height: getPHeight(300)),
            Container(
                width: getPWidth(1080),
                child: Text("Fill your registration form !",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: kPrimaryColor))),
            SizedBox(height: 5),
            buildFirstNameField(),
            SizedBox(height: 10),
            buildLastNameField(),
            SizedBox(height: 10),
            buildEmailField(),
            SizedBox(height: 10),
            buildPhoneNumberField(),
            SizedBox(height: 10),
            buildAddressField(),
            SizedBox(height: 10),
            buildPasswordField(),
            SizedBox(height: 10),
            buildConfirmPasswordField(),
            SizedBox(height: 10),
            Container(
              child: Column(
                children: List.generate(errors.length,
                    (index) => FormErrorText(text: errors[index])),
              ),
            ),
            SizedBox(height: 10),
            loading
                ? Container(
                    child: CircularProgressIndicator(
                        backgroundColor: kPrimaryColor))
                : Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: MaterialButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      minWidth: SizeConfig.screenWidth,
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus)
                          currentFocus.unfocus();
                        if (_registerFormKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          _registerFormKey.currentState.save();

                          String result =
                              await Provider.of<AuthenticationService>(context,
                                      listen: false)
                                  .signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          if (result == "Error") {
                            setState(() {
                              if (!errors.contains(kDatabaseError)) {
                                errors.add(kDatabaseError);
                              }
                            });
                          } else {
                            DatabaseService().createCIUser(
                                result,
                                firstNameController.text,
                                lastNameController.text,
                                addressController.text,
                                phoneController.text);
                            Navigator.pop(context);
                            // debugPrint("PopUpContext");
                          }

                          setState(() {
                            loading = false;
                          });
                        } else {
                          // debugPrint("Validation Failed!");
                        }
                      },
                      child: Text(
                        "REGISTER",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24),
                      ),
                    ),
                  ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(children: [
                Icon(Icons.arrow_back, size: 24, color: kPrimaryColor),
                SizedBox(width: 10),
                Text("Back to Login",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
              ]),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Container buildFakeRegisterButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        onPressed: () {},
        child: Text(
          "REGISTER",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.transparent,
              fontSize: 24),
        ),
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
          return kPasswordEmptyError;
        } else if (value.length < 6 &&
            !errors.contains(kPasswordInvalidError)) {
          setState(() {
            errors.add(kPasswordInvalidError);
          });
          return kPasswordInvalidError;
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
      controller: phoneController,
      decoration: getInputDecoration("Phone Number", Icons.phone),
    );
  }

  TextFormField buildAddressField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kAddressEmptyError)) {
          setState(() {
            errors.remove(kAddressEmptyError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kAddressEmptyError))
            setState(() {
              errors.add(kAddressEmptyError);
            });
        }
      },
      keyboardType: TextInputType.streetAddress,
      controller: addressController,
      decoration: getInputDecoration("Address", Icons.place),
    );
  }

  TextFormField buildConfirmPasswordField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: confirmPasswordController,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kConfirmPasswordEmpty)) {
          setState(() {
            errors.remove(kConfirmPasswordEmpty);
          });
        } else if ((value == passwordController.text) &&
            errors.contains(kConfrmPasswordIncorrectError)) {
          setState(() {
            errors.remove(kConfrmPasswordIncorrectError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kConfirmPasswordEmpty))
            setState(() {
              errors.add(kConfirmPasswordEmpty);
            });
          return kConfirmPasswordEmpty;
        } else if ((value != passwordController.text) &&
            !errors.contains(kConfrmPasswordIncorrectError)) {
          setState(() {
            errors.add(kConfrmPasswordIncorrectError);
          });

          debugPrint(
              "value: $value : confirmPassword: ${passwordController.value}");
          return kConfirmPasswordEmpty;
        }
      },
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: getInputDecoration("Confirm Password", Icons.lock),
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
          return kEmailEmptyError;
        } else if ((value.length <= 10) &&
            !errors.contains(kEmailInvalidError)) {
          setState(() {
            errors.add(kEmailInvalidError);
          });
          return kEmailInvalidError;
        }
      },
      keyboardType: TextInputType.name,
      decoration: getInputDecoration("Email Address", Icons.email),
    );
  }

  TextFormField buildFirstNameField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: firstNameController,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kFirstNameEmptyError)) {
          setState(() {
            errors.remove(kFirstNameEmptyError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kFirstNameEmptyError))
            setState(() {
              errors.add(kFirstNameEmptyError);
            });
          return "";
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: getInputDecoration("First Name", Icons.person),
    );
  }

  TextFormField buildLastNameField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: lastNameController,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kLastNameEmptyError)) {
          setState(() {
            errors.remove(kLastNameEmptyError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains(kLastNameEmptyError))
            setState(() {
              errors.add(kLastNameEmptyError);
            });
          return kLastNameEmptyError;
        }
      },
      keyboardType: TextInputType.name,
      decoration: getInputDecoration("Last Name", Icons.people),
    );
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
