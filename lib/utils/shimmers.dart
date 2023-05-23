import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app/utils/constants.dart';

class ShimmerWidgets {
  // ignore: unused_field
  final _shimmerGradient = LinearGradient(
    colors: [
      Colors.blue.withOpacity(0.4),
      Colors.blue,
      Colors.blue.withOpacity(0.4),
      Colors.blue,
    ],
    stops: [0.1, 0.3, 0.4, 0.6],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  Shimmer listSize() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.containerColor,
      highlightColor: Color.fromARGB(255, 9, 11, 122),
      child: Card(
        child: SizedBox(
          height: 70.sp,
          width: double.infinity,
        ),
      ),
    );
  }
}
