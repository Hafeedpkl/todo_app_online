import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/utils/constants.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch: ColorConstants.primarySwatch,
            primaryColor: ColorConstants.primaryColor),
        getPages: Routes.getPageList,
        initialRoute: StringConstants.homePage,
      );
    });
  }
}
