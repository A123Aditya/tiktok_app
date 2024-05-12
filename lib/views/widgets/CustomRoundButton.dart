import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRoundButton extends StatelessWidget {
  const CustomRoundButton({
    Key? key,
    required this.height,
    required this.width,
    required this.radius,
    this.buttonColor,
    this.onTap,
    this.icon,
    required this.buttomName,
    this.textcolor,
    required this.textFont,
    this.iconColor,
  }) : super(key: key);

  final double height;
  final double width;
  final double radius;
  final Color? buttonColor;
  final VoidCallback? onTap;
  final IconData? icon;
  final String buttomName;
  final Color? textcolor;
  final double textFont;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.green,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: buttonColor ?? Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon ?? Icons.abc_sharp,
              color: iconColor ?? Colors.purple.shade400,
            ),
            Text(
              buttomName,
              style: TextStyle(
                  color: textcolor,
                  fontSize: textFont,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
