import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:halley/config.dart';
import 'package:halley/firebase_options.dart';
import 'package:halley/routes.dart';
import 'package:halley/screen/auth/login.dart';
import 'package:halley/screen/home/home.dart';
import 'package:halley/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }

  await Config.loadConfig();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme(),
      dark: AppTheme.darkTheme(),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Halley',
        theme: theme,
        debugShowCheckedModeBanner: false,
        // Verifica se está logado ou não e direciona para login.
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return HomeScreen();
              } else {
                return const LoginScreen();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
