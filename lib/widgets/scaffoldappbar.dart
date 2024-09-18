import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'appbar.dart';

class ScaffoldWithAppBar extends StatelessWidget {
  final String title;
  final Widget body;
  final FirebaseAuth auth;

  const ScaffoldWithAppBar({super.key, required this.title, required this.body, required this.auth});

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: CustomAppBar(title: title, auth: auth),
      body: body,
    );
  }
}
