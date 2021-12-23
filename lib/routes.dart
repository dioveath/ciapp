import 'package:ciapp/screens/dashboard/components/profile/profile_screen.dart';
import 'package:ciapp/screens/dashboard/dashboard.dart';
import 'package:ciapp/screens/login/login_screen.dart';
import 'package:ciapp/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';



// all routes available here
final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName : (context) => WelcomeScreen(),
  LoginScreen.routeName : (context) => LoginScreen(),
  DashboardScreen.routeName : (context) => DashboardScreen(),
  ProfileScreen.routeName : (context) => ProfileScreen(), 
};
