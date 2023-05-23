import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/utils/constants.dart';

SizedBox hieght(double size) {
  return SizedBox(height: size);
}

Container customContainer(
    {Widget? child,
    double? height,
    double? width,
    Decoration? decoration,
    Color color = ColorConstants.containerColor}) {
  return Container(
    height: height,
    width: width,
    decoration: decoration ??
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
    child: child,
  );
}

Text reusableText(String text, TextStyle textStyle) {
  return Text(
    text,
    style: textStyle,
  );
}

TextStyle robotoText({double? fontsize}) {
  return GoogleFonts.roboto(color: Colors.white, fontSize: fontsize ?? 15);
}
