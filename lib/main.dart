import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:insa_demo_abhay/view/landing_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Insurance Samadhan',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        locale: const Locale("en", 'US'),
        home: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return LandingPage();
          },
        ));
  }
}
