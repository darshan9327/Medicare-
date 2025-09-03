import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare/Presentation/Cart/controllers/cart_controller.dart';
import 'package:medicare/Presentation/Common/utils/size_config.dart';
import 'package:medicare/Presentation/Splash/pages/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    Get.put(CartController(), permanent: true);
    SConfig.init(context);
    return GetMaterialApp(
      title: 'Medicare+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff478ef8))),
      home: SplashScreen(),
    );
  }
}