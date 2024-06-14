import 'package:auth_app/Provider/provider.dart';
import 'package:auth_app/screen/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.person,
                size: 32,
              ),
              tooltip: 'Profile',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UiProvider>(
              builder: (context, UiProvider notifier, child) {
                return TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/login');
                      notifier.logout(context);
                    },
                    child: Text("SIGN OUT"));
              },
            )
          ],
        ),
      ),
    );
  }
}
