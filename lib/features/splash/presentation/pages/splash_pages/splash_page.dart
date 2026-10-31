import 'dart:io';

import 'package:weathera/core/domain/presentation/widgets/error_panel.dart';
import 'package:weathera/core/utils/extentions.dart';
import 'package:weathera/features/splash/presentation/cubits/splash_cubit.dart';
import 'package:weathera/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startCounter(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.status == SplashStatus.done) {
            context.go(AppPaths.main.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: (state.status == SplashStatus.error)
                ? ErrorPanel(
                    failure: state.failure!,
                    onTryAgain: () =>
                        BlocProvider.of<SplashCubit>(context).startCounter(),
                  )
                : Stack(
                    children: [
                      SizedBox(
                        height: 1.sh,
                        width: 1.sw,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.wb_sunny_rounded,
                                size: 0.3.sw,
                                color: context.theme.primaryColor,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "general.app_name".tr(),
                                style: context.textTheme.displayLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).padding.bottom + 10.h,
                        right: 30,
                        left: 30,
                        child: Align(
                          alignment: Alignment.center,
                          child: (Platform.isAndroid)
                              ? const CircularProgressIndicator()
                              : const CupertinoActivityIndicator(),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
