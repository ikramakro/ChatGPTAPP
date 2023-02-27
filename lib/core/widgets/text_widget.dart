import 'package:chatgpt/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyText extends StatelessWidget {
  String title;
  double fontsize;
  Color? color;
  FontWeight? fontweight;
  MyText(
      {super.key,
      required this.title,
      this.fontsize = 18,
      this.color,
      this.fontweight});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontsize,
          color: color ?? kwhiteColor,
          fontWeight: fontweight ?? FontWeight.w500),
    );
  }
}
