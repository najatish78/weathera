import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

///Fonts documentation:
///
/// to access the styles you should use:
///   [ context.textTheme.headline1 ]
///   or
///   [ theme.of(context).textTheme.headline1 ]
///for [ Bold ] fonts you should use :
///  [ displayLarge ] => [ 22 ]
///  [ titleLarge ] => [ 12 ]
///
///
/// for [ SemiBold ] fonts you should use :
///  [ displayMedium ] => [ 20 ]
///  [ displaySmall ] => [ 18 ]
///  [ headlineMedium ] => [ 16 ]
///  [ headlineSmall ] => [ 14 ]
///
///  for [ Medium ] fonts you should use :
///  [ titleMedium ] => [ 16 ]
///  [ titleSmall ] => [ 12 ]
///
///  for [ Regular ] fonts you should use :
///  [ bodyLarge ] => [ 16 ]
///  [ bodyMedium ] => [ 12 ]
///
///  for [ Font Size 12 ] fonts you should use :
///  [ bodySmall ] => [ 12 ] and weight is medium
///
///  for [ Font Size 10 ] fonts you should use :
///  [ labelSmall ] => [ 10 ]  and weight is medium
///
/// In case of changes you should use [ copyWith ] to achieve wanted results

class AppTextTheme {
  // static const notoKufiArabicFamily = 'SST';
  // static final notoKufiArabicFamily = "ARB";
  static final notoKufiArabicFamily = GoogleFonts.notoKufiArabic().fontFamily;
  static const double fontHeight = 1;

  static TextTheme enTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 20.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontSize: 18.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      fontSize: 16.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      fontSize: 14.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 12.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      fontSize: 10.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontSize: 14.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontFamily: notoKufiArabicFamily,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontFamily: notoKufiArabicFamily,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: notoKufiArabicFamily,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: notoKufiArabicFamily,
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(fontFamily: notoKufiArabicFamily, fontSize: 9.sp),
    labelLarge: TextStyle(fontFamily: notoKufiArabicFamily, fontSize: 14.sp),
  );

  static TextTheme arTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 20.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: TextStyle(
      fontSize: 18.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      fontSize: 16.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      fontSize: 14.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 12.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      fontSize: 10.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 14.sp,
      fontFamily: notoKufiArabicFamily,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontFamily: notoKufiArabicFamily,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontFamily: notoKufiArabicFamily,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: notoKufiArabicFamily,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(fontFamily: notoKufiArabicFamily, fontSize: 10.sp),
    labelSmall: TextStyle(fontFamily: notoKufiArabicFamily, fontSize: 9.sp),
    labelLarge: TextStyle(fontFamily: notoKufiArabicFamily, fontSize: 14.sp),
  );
}
