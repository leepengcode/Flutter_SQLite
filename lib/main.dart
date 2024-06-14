import 'package:auth_app/Provider/provider.dart';
import 'package:auth_app/screen/HomeScreen.dart';
import 'package:auth_app/screen/LoginScreen.dart';
import 'package:auth_app/screen/ProfileScreen.dart';
import 'package:auth_app/screen/SigupScreen.dart';
import 'package:auth_app/screen/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UiProvider()..initStorage(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp(
            routes: {
              '/signup': (context) => SignupScreen(),
              '/login': (context) => LoginScreen(),
              '/profile': (context) => ProfileScreen(),
              '/home': (context) => HomeScreen(),
            },
            home: notifier.rememberMe ? HomeScreen() : welcomeScreen(),
          );
        },
      ),
    );
  }
}
