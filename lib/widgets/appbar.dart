import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final FirebaseAuth auth;

  const CustomAppBar({super.key, required this.title, required this.auth});

  @override
  Widget build(BuildContext context) {
    final adaptiveTheme = AdaptiveTheme.of(context);
    final isLightMode = adaptiveTheme.mode == AdaptiveThemeMode.light;
    final appBarColor = Theme.of(context).primaryColor;
    final isLoggedIn = auth.currentUser != null;

    return Container(
      height: 150,
      color: appBarColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  isLightMode ? Icons.dark_mode : Icons.light_mode,
                  color: isLightMode ? Colors.white : Colors.white,
                ),
                onPressed: () {
                  final newThemeMode = isLightMode
                      ? AdaptiveThemeMode.dark
                      : AdaptiveThemeMode.light;
                  adaptiveTheme.setThemeMode(newThemeMode);
                },
              ),
            ),
          ),
          SvgPicture.asset(
              'assets/halley_logo.svg',
              height: 25, 
            ),
          const SizedBox(height: 25),
          if (isLoggedIn)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Home'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/adddoac');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Adicionar itens'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/listdoac');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Estoque'),
                ),
                TextButton(
                  onPressed: () async {
                    await auth.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Logout'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
