import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_app/controllers/auth_controller.dart';

import 'views/screens/Profile_screen.dart';
import 'views/screens/add_videoScreen_post.dart';
import 'views/screens/home_Screen.dart';

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
const primarytextColor = Colors.white;
const secondarytextColor = Colors.black;
var tertiarytextColor = Colors.red[400];

// Pages
List<Widget> pages = [
  const ProfileScreen(),
  HomeScreen(),
   AddVideoScreen(),
   ProfileScreen(),
   AddVideoScreen(),
];

// Screen Size
const double screenHeight = 852;
const double screenWidth = 393;

// FireBase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

// Controllers
var authcontroller = AuthController.instance;
