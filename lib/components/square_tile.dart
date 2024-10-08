import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
final String imagePath;

const SquareTile({super.key,

 required this.imagePath,
 
 });

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFF00FFBC)),
      borderRadius: BorderRadius.circular(64),
      
      ),
      child: Image.asset(imagePath,
      height: 30,
      ),
    );
  }
}