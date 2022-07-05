import 'package:flutter/material.dart';

const kTitleColor = Color(0xFF130433);
// const kTitleColor = Colors.black;
const kPrimaryColor = Color(0xFF0EE8E1);
const kPrimaryAccentColor = Color(0xFF00DCFF);
const kPrimaryDarkAccentColor = Color(0xFF088f9c);
const kPrimaryAltAccentColor = Color(0xFF30a5b8);
const kSecondaryColor = Color(0xFF33308C);
const kSecondaryCompColor = Color(0xFF30808c);
const kTertiaryColor = Colors.amberAccent;
const kBackgroundColor = Color(0xFFECECEC);
const kDullColor = Color(0xFF4C5B63);

const kDisabledColor = Color(0xDD959595);

const kDarkGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    kSecondaryColor,
    kSecondaryColor,

    // kTitleColor,
    // kPrimaryAccentColor,
    // kPrimaryColor,
    // kPrimaryAltAccentColor,
    // kPrimaryDarkAccentColor,
  ],
);

// login error text,
const kPasswordInvalidError = "Enter a valid password (character >= 6)!";
const kEmailInvalidError = "Not valid email address";
const kPhoneInvalidError = "Not a phone number! (10 digits)";

const kEmailEmptyError = "Please enter your email address!";
const kPasswordEmptyError = "Please enter your password!";
const kPhoneEmptyError = "Please enter your phone number!";

const kPasswordIncorrectError = "Password is incorrect!";

const kFirstNameEmptyError = "Write your first name!";
const kLastNameEmptyError = "Write your last name!";
const kConfrmPasswordIncorrectError = "Confirmation password didn't match";
const kConfirmPasswordEmpty = "Confirm Password is empty!";
const kAddressEmptyError = "Write your address!";
const kDatabaseError = "There is some kind of error in the database!";

const List<String> kMonthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
