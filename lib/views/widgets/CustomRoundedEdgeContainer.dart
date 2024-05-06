import 'package:flutter/material.dart';

class CustomRoundedEdgeContainer extends StatelessWidget {
  const CustomRoundedEdgeContainer({super.key, required this.height, required this.width, required this.radius, this.containerColor, this.text, this.textColor, this.textfontSize});
  final double height;
  final double width;
  final double radius;
  final Color? containerColor;
  final String? text;
  final Color? textColor;
  final double? textfontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor ?? Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: Text(text!,style: TextStyle(
          color: textColor,
          fontSize: textfontSize,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}