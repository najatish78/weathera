import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weathera/core/domain/presentation/widgets/error_panel.dart';
import 'package:weathera/core/domain/presentation/widgets/loading_panel.dart';
import 'package:weathera/core/utils/extentions.dart';
import 'package:weathera/features/outfit/presentation/cubits/outfit_cubit/outfit_cubit.dart';
import 'package:weathera/features/outfit/presentation/widgets/outfit_card.dart';
import 'package:weathera/features/weather/presentation/cubits/current_weather_cubit/current_weather_cubit.dart';
import 'package:weathera/features/weather/presentation/widgets/current_weather_header.dart';
import 'package:weathera/features/weather/presentation/widgets/hourly_forecast_list.dart';
import 'package:weathera/features/weather/presentation/widgets/weather_details_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Read here, not inside `create`: the locale lookup listens for changes.
    final lang = context.locale.languageCode;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrentWeatherCubit(lang: lang)..load(),
        ),
        BlocProvider(create: (context) => OutfitCubit()),
      ],
      // Every new weather (first load, pull to refresh) asks for a new outfit.
      child: BlocConsumer<CurrentWeatherCubit, CurrentWeatherState>(
        listenWhen: (previous, current) =>
            current.data != null && previous.data != current.data,
        listener: (context, state) => context.read<OutfitCubit>().suggest(
          current: state.data!.current,
          forecast: state.data!.forecast,
        ),
        builder: (context, state) {
          final cubit = context.read<CurrentWeatherCubit>();
          final data = state.data;

          if (state.status == CurrentWeatherStatus.error && data == null) {
            return ErrorPanel(
              failure: state.failure!,
              actionLabel: state.needsAppSettings
                  ? 'general.open_settings'.tr()
                  : null,
              onTryAgain: state.needsAppSettings
                  ? cubit.openSettings
                  : cubit.load,
            );
          }
          if (data == null) return const LoadingPanel();

          return SafeArea(
            child: RefreshIndicator(
              onRefresh: cubit.refresh,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                children: [
                  CurrentWeatherHeader(
                    weather: data.current,
                    rainChance: data.forecast.maxRainChance(),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'outfit.title'.tr(),
                    style: context.textTheme.displaySmall,
                  ),
                  SizedBox(height: 12.h),
                  const OutfitCard(),
                  SizedBox(height: 24.h),
                  Text(
                    'weather.next_hours'.tr(),
                    style: context.textTheme.displaySmall,
                  ),
                  SizedBox(height: 12.h),
                  HourlyForecastList(items: data.forecast.items),
                  SizedBox(height: 24.h),
                  Text(
                    'weather.details'.tr(),
                    style: context.textTheme.displaySmall,
                  ),
                  SizedBox(height: 12.h),
                  WeatherDetailsGrid(weather: data.current),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
