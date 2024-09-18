import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halley/widgets/scaffoldappbar.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppBar(
        title: 'Halley',
        auth: _auth,
        body: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: SingleChildScrollView(
                      child: Text(
                        'Teste!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )))));
  }
}
