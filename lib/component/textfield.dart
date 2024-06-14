import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  final String hint;
  final IconData icon;
  final IconData? suffix_icon;
  final TextEditingController controller;
  final bool? passwordInvisible;
  final VoidCallback? onSuffixIconTap; // Add callback for suffix icon tap
  const textfield({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.passwordInvisible = false,
    this.suffix_icon,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: TextFormField(
          obscureText: passwordInvisible!,
          controller: controller,
          style: const TextStyle(color: Colors.white, fontSize: 17),
          decoration: InputDecoration(
              suffixIcon: suffix_icon != null
                  ? GestureDetector(
                      onTap: onSuffixIconTap, // Set the callback
                      child: Icon(
                        suffix_icon,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    )
                  : null,
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white),
              prefixIcon: Icon(
                icon,
                color: const Color.fromARGB(255, 0, 0, 0),
              )),
        ));
  }
}
