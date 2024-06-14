import 'package:auth_app/JSON/users.dart';
import 'package:auth_app/Provider/provider.dart';
import 'package:auth_app/SQLite/database_helper.dart';
import 'package:auth_app/component/global_varriable.dart';
import 'package:auth_app/component/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  // bool _isChecked = false;
  bool isLoginTrue = false;

  final db = Databasehelper();
  //Login
  // login() async {
  //   var res = await db.authenticate(
  //       Users(usrName: userController.text, password: pwdController.text));
  //   if (res == true) {
  //     if (!mounted) return;
  //     Navigator.pushNamed(context, '/profile', arguments: res);
  //   } else {
  //     setState(() {
  //       isLoginTrue = true;
  //     });
  //   }
  // }

  //Login
  login() async {
    Users? user = await db.getUser(userController.text);
    if (user != null && user.password == pwdController.text) {
      if (!mounted) return;
      Navigator.pushNamed(context, '/profile', arguments: user);
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                const Image(
                  image: AssetImage('assets/image/background.jpg'),
                ),
                const SizedBox(
                  height: 20,
                ),
                textfield(
                  hint: 'Email',
                  icon: Icons.email,
                  controller: userController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfield(
                    suffix_icon:
                        hintPwd ? Icons.visibility_off : Icons.visibility,
                    passwordInvisible: hintPwd,
                    hint: 'Password',
                    icon: Icons.key,
                    controller: pwdController,
                    onSuffixIconTap: () {
                      setState(() {
                        hintPwd = !hintPwd; // Toggle password visibility
                      });
                    }),
                Container(
                  width: double.infinity,
                  // color: Colors.black,
                  child: Consumer<UiProvider>(
                      builder: (context, UiProvider notifier, child) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      horizontalTitleGap: 1,
                      title: const Text("Remember me"),
                      leading: Checkbox(
                          fillColor: MaterialStatePropertyAll(Colors.blue),
                          value: notifier.isChecked,
                          onChanged: (value) => notifier.toggleCheck()),
                    );
                  }),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: Consumer<UiProvider>(
                    builder: (context, UiProvider notifier, child) {
                      return ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue)),
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () async {
                            Users? user = await db.getUser(userController.text);

                            if (user != null &&
                                user.password == pwdController.text) {
                              if (notifier.isChecked == true) {
                                notifier.setRememberMe();
                              }
                              if (!mounted) return;
                              Navigator.pushNamed(
                                context,
                                '/home',
                              );
                            } else {
                              setState(() {
                                isLoginTrue = true;
                              });
                            }
                          });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?"),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          " SIGN UP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoginTrue
                    ? Text(
                        "Email or password is incorrect",
                        style: TextStyle(color: Colors.red.shade900),
                      )
                    : const SizedBox()
              ],
            )),
      ),
    )));
  }
}
