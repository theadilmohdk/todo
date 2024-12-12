import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecuretext;
  const LoginTextField(
      {super.key, required this.controller, required this.hintText, required this.obsecuretext});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: width/1.2,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              // labelText: 'Enter Name',
              hintText: hintText,
              fillColor: Colors.red,
              //enabledBorder: OutlineInputBorder(borderSide: BorderSide())
              ),
              obscureText: obsecuretext,
            
        ),
      ),
    );
  }
}
