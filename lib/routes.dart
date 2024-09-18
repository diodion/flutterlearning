import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halley/screen/auth/login.dart';
import 'package:halley/screen/auth/register.dart';
import 'package:halley/screen/home/adcdoac.dart';
import 'package:halley/screen/home/home.dart';
import 'package:halley/screen/home/listdoac.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final bool isAuthenticated = FirebaseAuth.instance.currentUser != null;

    switch (settings.name) {
      case '/registrar':
        return MaterialPageRoute(
            builder: (context) =>
                isAuthenticated ? HomeScreen() : const RegisterScreen());
      case '/login':
        return MaterialPageRoute(
            builder: (context) =>
                isAuthenticated ? HomeScreen() : const LoginScreen());
      case '/home':
        return MaterialPageRoute(
            builder: (context) =>
                isAuthenticated ? HomeScreen() : const LoginScreen());
      case '/adddoac':
        return MaterialPageRoute(
            builder: (context) =>
                isAuthenticated ? const AddDoac() : const LoginScreen());
      case '/listdoac':
        return MaterialPageRoute(
            builder: (context) =>
                isAuthenticated ? const DoacoesScreen() : const LoginScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => const LoginScreen());
    }
  }
}
