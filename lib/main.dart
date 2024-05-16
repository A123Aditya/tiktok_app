import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/constants.dart';
import 'package:tiktok_app/controllers/auth_controller.dart';
import 'package:tiktok_app/views/screens/auth/login_screen.dart';

import 'views/screens/add_videoScreen_post.dart';
import 'views/screens/auth/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(screenWidth, screenHeight),
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark()
                .copyWith(scaffoldBackgroundColor: backgroundColor),
            // home: LoginScreen(),
            home: AddVideoScreen(),
          );
        });
  }
}
