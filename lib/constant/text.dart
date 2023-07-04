import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nepalihiphub/constant/app_colors.dart';

const String fontfamily = 'Poppins';

final darkTextTheme = ThemeData().textTheme.copyWith(
    titleLarge: TextStyle(
        fontFamily: fontfamily,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: white),
    labelMedium: TextStyle(
        fontFamily: fontfamily,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: white),
    titleMedium: TextStyle(
      fontSize: 18.2.sp,
      fontWeight: FontWeight.w500,
      fontFamily: fontfamily,
      color: white,
    ),
    titleSmall: TextStyle(
      fontSize: 15.6.sp,
      fontWeight: FontWeight.w500,
      fontFamily: fontfamily,
      color: white,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      fontFamily: fontfamily,
      color: white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontFamily: fontfamily,
      color: white,
    ),
    bodySmall: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      fontFamily: fontfamily,
      color: white,
    ),
    labelSmall: TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      fontFamily: fontfamily,
      color: white,
    ));
