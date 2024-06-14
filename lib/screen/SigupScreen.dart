import 'package:auth_app/JSON/users.dart';
import 'package:auth_app/SQLite/database_helper.dart';
import 'package:auth_app/component/global_varriable.dart';
import 'package:auth_app/component/textfield.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  final db = Databasehelper();
  bool isUserExist = false;

  sigup() async {
    bool UserExist = await db.userExists(userController.text);
    if (UserExist) {
      setState(() {
        isUserExist = true;
      });
    } else {
      var res = await db.createUser(Users(
        fullName: nameController.text,
        usrName: userController.text,
        password: pwdController.text,
        email: emailController.text,
      ));
      if (res > 0) {
        if (!mounted) return;
        Navigator.pushNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Scaffold(
                body: Center(
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Register New Account",
              style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(
              height: 40,
            ),
            textfield(
                hint: 'Full Name',
                icon: Icons.person,
                controller: nameController),
            const SizedBox(
              height: 10,
            ),
            textfield(
                hint: 'Email', icon: Icons.email, controller: emailController),
            const SizedBox(
              height: 10,
            ),
            textfield(
                hint: 'Username',
                icon: Icons.contrast,
                controller: userController),
            const SizedBox(
              height: 10,
            ),
            textfield(
                suffix_icon: hintPwd ? Icons.visibility_off : Icons.visibility,
                passwordInvisible: hintPwd,
                hint: 'Password',
                icon: Icons.key,
                controller: pwdController,
                onSuffixIconTap: () {
                  setState(() {
                    hintPwd = !hintPwd; // Toggle password visibility
                  });
                }),
            const SizedBox(
              height: 10,
            ),
            textfield(
                suffix_icon: hintPwd ? Icons.visibility_off : Icons.visibility,
                passwordInvisible: hintPwd,
                hint: 'Re-Password',
                icon: Icons.key,
                controller: confirmPwdController,
                onSuffixIconTap: () {
                  setState(() {
                    hintPwd = !hintPwd; // Toggle password visibility
                  });
                }),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                child: Text(
                  "SIGN UP",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () {
                  sigup();
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You already have an account?"),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      " LOGIN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            isUserExist
                ? Text(
                    "Username already exist. Enter a new username",
                    style: TextStyle(color: Colors.red.shade900),
                  )
                : const SizedBox()
          ],
        ),
      )),
    ))));
  }
}
