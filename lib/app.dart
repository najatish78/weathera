import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'core/domain/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'core/domain/presentation/blocs/theme_bloc/theme_state.dart';
import 'core/domain/presentation/resources/theme/app_color_scheme.dart';
import 'core/domain/presentation/resources/theme/app_theme.dart';
import 'di/injection.dart';

class App extends StatelessWidget {
  const App({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => getIt<ThemeBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          var themeMode = ThemeMode.light;
          if (state is ThemeInitial) {
            themeMode = state.isDarkMode ? ThemeMode.dark : ThemeMode.light;
          } else if (state is DarkThemeState) {
            themeMode = ThemeMode.dark;
          } else if (state is LightThemeState) {
            themeMode = ThemeMode.light;
          }

          return ScreenUtilInit(
            designSize: const Size(350, 750),
            minTextAdapt: true,
            splitScreenMode: true,
            fontSizeResolver: (fontSize, instance) {
              var tempWidth = instance.screenWidth / 380;
              return fontSize.toDouble() * tempWidth;
            },
            builder: (context, child) {
              return MaterialApp.router(
                routerConfig: router,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'Weathera',
                theme: AppTheme(AppLightColorScheme()).getThemeData(context),
                darkTheme: AppTheme(AppDarkColorScheme()).getThemeData(context),
                themeMode: themeMode,
              );
            },
            child: Container(),
          );
        },
      ),
    );
  }
}
