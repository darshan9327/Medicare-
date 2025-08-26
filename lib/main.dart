import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Presentation/Common/utils/size_config.dart';
import 'Presentation/Splash/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SConfig.init(context);
    return GetMaterialApp(
      title: 'Medicare+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff478ef8))
      ),
      home: SplashScreen()
    );
  }
}