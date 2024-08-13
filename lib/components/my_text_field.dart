import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
 final TextEditingController controller;
 final String hintText;
 final bool obscureText;
 final Icon? prefixIcon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,  

    });
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
    child: SingleChildScrollView(
      child: 
    Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Color(0xFF00FFBC)),
            decoration: InputDecoration(
              
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
               borderSide: const BorderSide(color: Color(0xFF00FFBC)),),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Color(0xFF009971)),),
                fillColor: const Color(0xFF1a282f),
                filled: true,
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFF009971)),
                prefixIcon: prefixIcon, 


            )  
                 
              )
            ))
  );
  }
}

