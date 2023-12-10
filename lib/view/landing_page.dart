import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insa_demo_abhay/view/home_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LandingPage extends StatelessWidget {

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 13.5.sp);

  final TextStyle selectedLabelStyle = TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13.5.sp);

  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white70,
      body: HomeScreen(),
    ));
  }
}
