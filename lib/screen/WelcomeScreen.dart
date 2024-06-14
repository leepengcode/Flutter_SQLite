import 'package:auth_app/component/button.dart';
import 'package:auth_app/component/color.dart';
import 'package:flutter/material.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Authentication",
                      style: header,
                    ),
                    Text(
                      "Authenticate to  access your vital information",
                      style: subheader,
                    )
                  ],
                ),
                Column(
                  children: [
                    Image(image: AssetImage('assets/image/startup.jpg'))
                  ],
                ),
                Column(
                  children: [
                    Button_widget(
                      title: "LOGIN",
                      route: '/login',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Button_widget(
                      title: "SIGNUP",
                      route: '/signup',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
