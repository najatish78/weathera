import 'package:weathera/core/domain/presentation/resources/theme/app_color.dart';
import 'package:weathera/core/domain/presentation/resources/theme/app_text_theme.dart';
import 'package:weathera/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color_scheme.dart';

class AppTheme {
  final AppColorScheme appColorScheme;

  AppTheme(this.appColorScheme);

  ThemeData getThemeData(BuildContext context) {
    final textTheme = context.locale.languageCode == "en"
        ? AppTextTheme.enTextTheme
        : AppTextTheme.arTextTheme;

    return ThemeData(
      primaryColor: appColorScheme.primaryColor,
      primarySwatch: _generateMaterialColor(),
      brightness: context.isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: appColorScheme.backgroundColor,
      cardColor: appColorScheme.cardBackgroundColor,
      cardTheme: CardThemeData(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        color: appColorScheme.cardBackgroundColor,
        surfaceTintColor: appColorScheme.cardBackgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: appColorScheme.dividerColor),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: appColorScheme.cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      canvasColor: appColorScheme.backgroundAccentColor,
      focusColor: appColorScheme.infoTextColor,
      dividerColor: appColorScheme.dividerColor,
      hintColor: appColorScheme.placeholderColor,
      disabledColor: appColorScheme.placeholderColor,
      dialogTheme: DialogThemeData(
        backgroundColor: appColorScheme.cardBackgroundColor,
        surfaceTintColor: appColorScheme.cardBackgroundColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appColorScheme.cardBackgroundColor,
        surfaceTintColor: appColorScheme.cardBackgroundColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: appColorScheme.primaryColor,
        selectionColor: appColorScheme.primaryColor.withValues(alpha: 0.4),
        selectionHandleColor: appColorScheme.primaryColor,
      ),
      iconTheme: IconThemeData(color: appColorScheme.iconTintColor),
      primaryIconTheme: IconThemeData(color: appColorScheme.iconTintColor),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: appColorScheme.accentColor,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(
            appColorScheme.elevatedButtonTextColor.withAlpha(50),
          ),
          foregroundColor: WidgetStateProperty.all(
            appColorScheme.elevatedButtonTextColor,
          ),
          backgroundColor: WidgetStateProperty.all(
            appColorScheme.buttonBackgroundColor,
          ),
          elevation: WidgetStateProperty.all(1),
          textStyle: WidgetStateProperty.all(
            textTheme.bodyMedium!.copyWith(
              color: appColorScheme.elevatedButtonTextColor,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: textTheme.headlineSmall!.copyWith(
          color: appColorScheme.primaryFontColor,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: appColorScheme.appBarIconColor),
        surfaceTintColor: appColorScheme.primaryFontColor,
        scrolledUnderElevation: 0,
        backgroundColor: appColorScheme.appBarColor,
      ),
      textTheme: textTheme.apply(
        displayColor: appColorScheme.primaryFontColor,
        bodyColor: appColorScheme.secondaryFontColor,
      ),
      fontFamily: context.locale.languageCode == "en"
          ? AppTextTheme.notoKufiArabicFamily
          : AppTextTheme.notoKufiArabicFamily,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: appColorScheme.secondaryFontColor),
        hintStyle: TextStyle(color: appColorScheme.placeholderColor),
        fillColor: appColorScheme.cardBackgroundColor,
        filled: true,
        prefixIconColor: appColorScheme.iconTintColor,
        suffixIconColor: appColorScheme.iconTintColor,
        iconColor: appColorScheme.iconTintColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: appColorScheme.primaryColor,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColorScheme.inputBorderColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColorScheme.dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColorScheme.errorColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColorScheme.errorColor, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: appColorScheme.inputBorderColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        errorStyle: TextStyle(color: appColorScheme.errorColor),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 7, 14, 7),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 17.h, horizontal: 16.w),
          ),
          overlayColor: WidgetStateProperty.all(
            appColorScheme.elevatedButtonTextColor.withAlpha(50),
          ),
          foregroundColor: WidgetStateProperty.all(
            appColorScheme.elevatedButtonTextColor,
          ),
          backgroundColor: WidgetStateProperty.all(
            appColorScheme.buttonBackgroundColor,
          ),
          elevation: WidgetStateProperty.all(1),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          textStyle: WidgetStateProperty.all(
            textTheme.bodyMedium!.copyWith(
              color: appColorScheme.elevatedButtonTextColor,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return AppColors.grey.shade200;
        }),

        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return appColorScheme.primaryColor;
          }
          return AppColors.grey[50];
        }),
        materialTapTargetSize:
            MaterialTapTargetSize.shrinkWrap, // Keep size consistent
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 17.h, horizontal: 16.w),
          ),
          overlayColor: WidgetStateProperty.all(
            appColorScheme.primaryColor.withAlpha(50),
          ),
          foregroundColor: WidgetStateProperty.all(appColorScheme.primaryColor),
          backgroundColor: WidgetStateProperty.all(
            appColorScheme.backgroundColor,
          ),
          elevation: WidgetStateProperty.all(0),
          side: WidgetStateProperty.all(
            BorderSide(color: appColorScheme.primaryColor),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: appColorScheme.primaryColor),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            textTheme.bodyMedium!.copyWith(
              color: appColorScheme.outlineButtonTextColor,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
      unselectedWidgetColor: appColorScheme.infoTextColor,
      datePickerTheme: const DatePickerThemeData(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColorScheme.backgroundColor,
        showUnselectedLabels: true,
        selectedItemColor: appColorScheme.primaryColor,
        unselectedItemColor: appColorScheme.iconTintColor,
        unselectedLabelStyle: textTheme.bodyMedium!.copyWith(fontSize: 10.sp),
        selectedLabelStyle: textTheme.bodyMedium!.copyWith(fontSize: 9.sp),
      ),
      tabBarTheme: TabBarThemeData(
        unselectedLabelColor: appColorScheme.secondaryFontColor,
        labelColor: appColorScheme.primaryColor,
        labelStyle: textTheme.headlineMedium?.copyWith(
          overflow: TextOverflow.fade,
          color: Theme.of(context).primaryColor,
        ),
        unselectedLabelStyle: textTheme.headlineMedium,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: appColorScheme.primaryColor,
            width: 4.h,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          foregroundColor: appColorScheme.buttonBackgroundColor,
        ),
      ),
    );
  }

  MaterialColor _generateMaterialColor() {
    return MaterialColor(appColorScheme.primaryColor.toARGB32(), {
      50: _tintColor(appColorScheme.primaryColor, 0.9),
      100: _tintColor(appColorScheme.primaryColor, 0.8),
      200: _tintColor(appColorScheme.primaryColor, 0.6),
      300: _tintColor(appColorScheme.primaryColor, 0.4),
      400: _tintColor(appColorScheme.primaryColor, 0.2),
      500: appColorScheme.accentColor,
      600: _shadeColor(appColorScheme.primaryColor, 0.1),
      700: _shadeColor(appColorScheme.primaryColor, 0.2),
      800: _shadeColor(appColorScheme.primaryColor, 0.3),
      900: _shadeColor(appColorScheme.primaryColor, 0.4),
    });
  }

  Color _tintColor(Color color, double factor) =>
      Color.lerp(color, Colors.white, factor)!;

  Color _shadeColor(Color color, double factor) =>
      Color.lerp(color, Colors.black, factor)!;
}

ThemeData getDatePickerTheme(BuildContext context) {
  return Theme.of(context).copyWith(
    colorScheme: Theme.of(context).colorScheme.copyWith(
      primary: Theme.of(context).colorScheme.secondary,
      onSurface: Theme.of(context).textTheme.bodyLarge!.color,
    ),
  );
}
