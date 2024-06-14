import 'package:flutter/material.dart';

class Button_widget extends StatelessWidget {
  final String title;
  final String? route;
  final VoidCallback? onPressed;

  const Button_widget({
    super.key,
    required this.title,
    this.route,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.blue)),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
          if (route != null) {
            Navigator.pushNamed(context, route!);
          }
        },
      ),
    );
  }
}
