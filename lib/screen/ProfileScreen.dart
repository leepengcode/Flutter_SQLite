import 'package:auth_app/JSON/users.dart';
import 'package:auth_app/component/button.dart';
import 'package:auth_app/component/color.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Users? user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Users?;
    setState(() {
      user = args;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CircleAvatar(
                    maxRadius: 80,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/image/no_user.jpg'),
                      radius: 77,
                    ),
                  ),
                  Text(
                    user?.fullName ?? "No Name",
                    style: header,
                  ),
                  Text(user?.email ?? "No Email",
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold)),
                  Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(user?.fullName ?? "No Name"),
                    subtitle: const Text("Full Name"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(user?.email ?? "No Email"),
                    subtitle: const Text("Email"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(user?.usrName ?? "No Username"),
                    subtitle: const Text("Username"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Button_widget(title: 'LOG OUT', route: '/login'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
