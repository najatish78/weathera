import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weathera/core/domain/presentation/resources/theme/app_color_scheme.dart';
import 'package:weathera/core/utils/extentions.dart';
import 'package:weathera/features/weather/data/model/current_weather_model.dart';

/// Big card at the top: place, temperature, condition and today's range.
class CurrentWeatherHeader extends StatelessWidget {
  const CurrentWeatherHeader({
    super.key,
    required this.weather,
    required this.rainChance,
  });

  final CurrentWeatherModel weather;

  /// Highest chance of rain over the next 24 hours, 0..1.
  final double rainChance;

  @override
  Widget build(BuildContext context) {
    final onCard = Colors.white;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [WeatheraPalette.brandPrimary, WeatheraPalette.rainy],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_rounded, color: onCard, size: 18.r),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  [
                    weather.cityName,
                    weather.country,
                  ].where((e) => e.isNotEmpty).join(', '),
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: onCard,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weather.temp.round()}°',
                      style: TextStyle(
                        fontSize: 64.sp,
                        fontWeight: FontWeight.w700,
                        color: onCard,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      weather.condition.description,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: onCard,
                      ),
                    ),
                  ],
                ),
              ),
              CachedNetworkImage(
                imageUrl: weather.condition.iconUrl,
                width: 110.r,
                height: 110.r,
                errorWidget: (_, _, _) => const SizedBox.shrink(),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _Chip(
                icon: Icons.thermostat_rounded,
                label: 'weather.feels_like'.tr(
                  namedArgs: {'value': '${weather.feelsLike.round()}°'},
                ),
              ),
              _Chip(
                icon: Icons.swap_vert_rounded,
                label:
                    '${weather.tempMax.round()}° / ${weather.tempMin.round()}°',
              ),
              _Chip(
                icon: Icons.umbrella_rounded,
                label: 'weather.rain_chance'.tr(
                  namedArgs: {'value': '${(rainChance * 100).round()}%'},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16.r),
          SizedBox(width: 4.w),
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
