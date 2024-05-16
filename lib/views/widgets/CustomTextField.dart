import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.height,
      required this.width,
      required this.radius,
      this.borderColor,
      this.hintText,
      this.suffixicon,
      this.leftpadding,
      this.rightpadding,
      this.toppadding,
      this.bottompadding,
      this.hinttextColor,
      this.suffixiconColor,
      this.isobsecureText,
      required this.textEditingController,
      this.prefixIcon,
      this.ontapIcon});
  final double height;
  final double width;
  final double radius;
  final Color? borderColor;
  final Color? hinttextColor;
  final String? hintText;
  final Icon? suffixicon;
  final Color? suffixiconColor;
  final double? leftpadding;
  final double? rightpadding;
  final double? toppadding;
  final double? bottompadding;
  final bool? isobsecureText;
  final TextEditingController textEditingController;
  final Icon? prefixIcon;
  final Callback? ontapIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextField(
        obscureText: isobsecureText ?? false,
        controller: textEditingController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                left: leftpadding ?? 16.w,
                top: toppadding ?? 16.h,
                right: rightpadding ?? 191.w),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderColor ?? Colors.white)),
            hintText: hintText,
            hintStyle: TextStyle(color: hinttextColor ?? Colors.white),
            prefixIcon: prefixIcon,
            suffixIcon: suffixicon,
            suffixIconColor: suffixiconColor ?? Colors.white),
      ),
    );
  }
}

class CustomPasswordField extends StatelessWidget {
  const CustomPasswordField({
    Key? key,
    required this.height,
    required this.width,
    required this.radius,
    this.borderColor,
    this.hintText,
    required this.textEditingController,
    this.prefixIcon,
    this.ontapIcon,
    this.leftpadding,
    this.rightpadding,
    this.toppadding,
    this.bottompadding,
    this.hinttextColor,
    this.suffixiconColor,
    this.isobsecureText,
    required this.suffixicon,
  }) : super(key: key);

  final double height;
  final double width;
  final double radius;
  final Color? borderColor;
  final Color? hinttextColor;
  final String? hintText;
  final Icon? suffixicon;
  final Color? suffixiconColor;
  final double? leftpadding;
  final double? rightpadding;
  final double? toppadding;
  final double? bottompadding;
  final bool? isobsecureText;
  final TextEditingController textEditingController;
  final Icon? prefixIcon;
  final VoidCallback? ontapIcon; // Use VoidCallback for onTap function

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextField(
        obscureText: isobsecureText ?? false,
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: leftpadding ?? 16.w,
            top: toppadding ?? 16.h,
            // right: rightpadding ?? 191.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: borderColor ?? Colors.white),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: hinttextColor ?? Colors.white),
          prefixIcon: prefixIcon,
          suffixIcon: InkWell(
            onTap: ontapIcon, // Invoke the ontapIcon function
            child: suffixicon,
          ),
          suffixIconColor: suffixiconColor ?? Colors.white,
        ),
      ),
    );
  }
}
