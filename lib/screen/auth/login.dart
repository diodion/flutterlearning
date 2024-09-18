import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halley/widgets/button.dart';
import 'package:halley/config.dart';
import 'package:halley/widgets/scaffoldappbar.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        clientId: Config.googleClientId!,
      ).signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro: ${e.toString()}';
      });
    }
  }

  Future<void> _signInWithEmailPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro: ${e.toString()}';
      });
    }
  }

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
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: 500,
                    child: ButtonHalley(
                      text: 'Entrar',
                      onPressed: _signInWithEmailPassword,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: 500,
                    child: SignInButton(
                      Buttons.google,
                      text: "Entrar com Google",
                      onPressed: _signInWithGoogle,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: 500,
                    child: SignInButton(
                      Buttons.facebook,
                      text: "Entrar com Facebook",
                      onPressed: _signInWithGoogle,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Não está registrado? ',
                        style: TextStyle(fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registrar');
                        },
                        child: const Text(
                          'Registre com email clicando aqui',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
