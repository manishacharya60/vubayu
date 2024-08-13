import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: unused_import
import 'home.dart';
import 'login_page.dart';




class Splash extends StatefulWidget {
const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
}

_navigatetohome()async{
await Future.delayed(const Duration(milliseconds: 4000), (){});
// ignore: use_build_context_synchronously
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()   ));

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set background color to #1a282f
      backgroundColor: const Color(0xFF1A282F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Replace AssetImage with your logo asset
            Image.asset(
              'assets/logo.png',
              width: 120,  // Adjust the size as necessary
              height: 120,
              // Optionally, you can add a color filter to the logo if needed
                // Apply a white color filter to the logo
              // colorBlendMode: BlendMode.modulate,  // Adjust the blend mode if necessary
            ),
            // Optionally, add a loading indicator or text below the logo
           
               LoadingAnimationWidget.newtonCradle(
        color: const Color(0xFF00FFBC),
        size: 80,
      ),
        ],
        ),
      ),
    );
  }
}