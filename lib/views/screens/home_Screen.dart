import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_app/constants.dart';
import 'package:tiktok_app/views/screens/add_videoScreen_post.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List text = ["Aditya", "Ayush", "ram", "Shyam", "Lakshman"];

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.white,
        // color: Colors.white24
        //     .withOpacity(1)
        //     .withAlpha(
        //       200,
        //     )
        //     .withBlue(255)
        //     .withRed(240),
        onTap: (ind) {
          setState(() {
            currentPageIndex = ind;
          });
        },
        // index: 2,
        items: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Icons/home.png"))),
          ),
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/Icons/search-interface-symbol.png"))),
          ),
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Icons/video.png"))),
          ),
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Icons/user.png"))),
          ),
          // Container(
          //   height: 40.h,
          //   width: 40.w,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage("assets/Icons/home.png"))),
          // ),
        ],
      ),
    );
  }
}
