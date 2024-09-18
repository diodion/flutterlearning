import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halley/widgets/button.dart';
import 'package:halley/widgets/scaffoldappbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String _errorMessage = '';
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  Future<void> _registerWithEmailPassword() async {
    try {
      // Começa validação
      if (_emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _nameController.text.isEmpty ||
          _lastNameController.text.isEmpty) {
        setState(() {
          _errorMessage = 'Preencha todos os campos.';
        });
        return;
      }

      if (!_isValidPassword(_passwordController.text)) {
        setState(() {
          _errorMessage =
              'A senha deve conter no minimo 8 caracteres, ter uma letra maiscula e miniscula e ter um caracter especial.';
        });
        return;
      }

      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    }
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=])")
            .hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppBar(
        title: 'Halley - Registrar',
        auth: _auth,
        body: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              constraints: const BoxConstraints(maxWidth: 500),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        decoration: const InputDecoration(
                          labelText: 'Email', prefixIcon: Icon(Icons.email),
                        )),
                    const SizedBox(height: 10),
                    TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        decoration: const InputDecoration(
                            labelText: 'Nome', prefixIcon: Icon(Icons.person))),
                    const SizedBox(height: 10),
                    TextFormField(
                        controller: _lastNameController,
                        focusNode: _lastNameFocusNode,
                        decoration: const InputDecoration(
                            labelText: 'Sobrenome', prefixIcon: Icon(Icons.person_outline))),
                    const SizedBox(height: 10),
                    TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Senha', prefixIcon: Icon(Icons.lock))),
                    const SizedBox(height: 5),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Atenção: A senha deve conter no minimo 8 caracteres e possuir:\n'
                        '• Uma letra maiscula\n'
                        '• Uma letra minuscula\n'
                        '• Um numero\n'
                        '• Um caracter especial: @ # \$ % ^ & + =',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        height: 40,
                        width: 500,
                        child: ButtonHalley(
                            text: 'Registrar',
                            onPressed: _registerWithEmailPassword)),
                    const SizedBox(height: 10),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                            height: 40,
                            width: 40,
                            child: IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.blue),
                                onPressed: () {
                                  Navigator.pop(context);
                                }))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
