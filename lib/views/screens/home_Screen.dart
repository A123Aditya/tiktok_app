import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: Colors.deepPurple,
      body: pages[currentPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        color: Colors.deepPurple.shade200,
        onTap: (ind) {
          setState(() {
            currentPageIndex = ind;
          });
        },
        // index: 2,
        items: [
          Icon(
            Icons.home,
            color: Colors.black,
          ),
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          Icon(
            Icons.post_add,
            color: Colors.black,
          ),
          Icon(
            Icons.message,
            color: Colors.black,
          ),
          Icon(
            Icons.person,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
