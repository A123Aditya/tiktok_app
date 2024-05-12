import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../widgets/CustomRoundedEdgeContainer.dart';
import '../../widgets/CustomTextField.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userNameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  RxBool _isobsecure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 205.w, top: 174.h),
              child: Container(
                width: 140.w,
                height: 28.h,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    "Welcome",
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w),
              child: Container(
                width: 327.w,
                height: 48.h,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, you must create an account and",
                        style: TextStyle(
                            fontSize: 14.sp, color: Color(0xFF888888)),
                      ),
                      Text(
                        "then login into the application and enjoy all the features",
                        style: TextStyle(
                            fontSize: 14.sp, color: Color(0xFF888888)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg"),
                  ),
                  Positioned(
                      left: 55.w,
                      right: 10.w,
                      top: 5.h,
                      bottom: 45.h,
                      child: IconButton(
                          color: buttonColor,
                          onPressed: () {
                            print("tapped");
                            authcontroller.pickImage();
                          },
                          icon: Icon(Icons.add_a_photo)))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, right: 274.w, left: 24.w),
              child: Container(
                width: 60.w,
                height: 14.h,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    "UserName",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF888888)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h, right: 24.w, left: 24.w),
              child: CustomTextField(
                height: 48.h,
                width: 327.w,
                radius: 24.r,
                hintText: "Enter Your Name",
                textEditingController: _userNameController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, right: 274.w, left: 24.w),
              child: Container(
                width: 77.w,
                height: 14.h,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    "Email Address",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF888888)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h, right: 24.w, left: 24.w),
              child: CustomTextField(
                height: 48.h,
                width: 327.w,
                radius: 24.r,
                hintText: "Enter Your Email",
                textEditingController: _emailController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h, right: 274.w, left: 24.w),
              child: Container(
                width: 53.w,
                height: 14.h,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF888888)),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 16.h, right: 24.w, left: 24.w),
                child: Obx(
                  () => CustomPasswordField(
                    ontapIcon: () {
                      _isobsecure.value = !_isobsecure.value;
                    },
                    height: 48.h,
                    width: 327.w,
                    radius: 24.r,
                    hintText: "Enter Your Password",
                    textEditingController: _passwordController,
                    isobsecureText: _isobsecure.value,
                    suffixicon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: primarytextColor,
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: 35.w, right: 30.w, top: 50.h),
              child: InkWell(
                onTap: () => authcontroller.registerUser(
                    _userNameController.text,
                    _emailController.text,
                    _passwordController.text,
                    authcontroller.profilePic),
                child: CustomRoundedEdgeContainer(
                  height: 56.h,
                  width: 300.w,
                  radius: 32.r,
                  containerColor: Color(0xFFF8623A),
                  text: "Sign Up",
                  textColor: primarytextColor,
                  textfontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
