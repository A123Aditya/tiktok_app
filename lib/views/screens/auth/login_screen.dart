import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../widgets/CustomRoundButton.dart';
import '../../widgets/CustomRoundedEdgeContainer.dart';
import '../../widgets/CustomTextField.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            padding: EdgeInsets.only(left: 24.w, right: 183.w, top: 174.h),
            child: Container(
              width: 168.w,
              height: 28.h,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  "Login Account",
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
                      "Hello, you must login first to be able to use the",
                      style:
                          TextStyle(fontSize: 14.sp, color: Color(0xFF888888)),
                    ),
                    Text(
                      "application and enjoy all the features",
                      style:
                          TextStyle(fontSize: 14.sp, color: Color(0xFF888888)),
                    )
                  ],
                ),
              ),
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
            padding: EdgeInsets.only(left: 245.w, top: 16.h, right: 24.w),
            child: Container(
              height: 14.h,
              width: 106.w,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEA9459),
                        fontSize: 12.sp),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 35.w, right: 30.w, top: 50.h),
            child: InkWell(
              onTap: () {
                authcontroller.loginUser(
                    _emailController.text, _passwordController.text);
              },
              child: CustomRoundedEdgeContainer(
                height: 56.h,
                width: 327.w,
                radius: 32.r,
                containerColor: Color(0xFFF8623A),
                text: "Sign In",
                textColor: primarytextColor,
                textfontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Center(
            child: Text(
              "Or SignIn With..",
              style: TextStyle(color: primarytextColor, fontSize: 14.sp),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24.w, top: 24.h, right: 16.w),
                child: CustomRoundButton(
                  onTap: () {
                    print("tapped Google signin");
                  },
                  textcolor: secondarytextColor,
                  icon: FontAwesomeIcons.google,
                  iconColor: secondarytextColor,
                  height: 48.h,
                  radius: 32.r,
                  width: 155.w,
                  buttonColor: Color(0xFFFAFAFA),
                  buttomName: "Google",
                  textFont: 14.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 24.h, right: 24.w),
                child: CustomRoundButton(
                  onTap: () {
                    print("tapped facebook signin");
                  },
                  textcolor: secondarytextColor,
                  icon: FontAwesomeIcons.facebookF,
                  height: 48.h,
                  radius: 32.r,
                  width: 155.w,
                  buttonColor: Color(0xFFFAFAFA),
                  buttomName: "Facebook",
                  textFont: 14.sp,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 24.h,
              right: 178.w,
              left: 24.w,
            ),
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(color: primarytextColor),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Join us',
                    style: TextStyle(
                      color: tertiarytextColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("join us tapped");
                      },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
