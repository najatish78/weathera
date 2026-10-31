import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weathera/core/utils/extentions.dart';
import 'package:weathera/features/weather/data/model/current_weather_model.dart';

/// Humidity, wind, clouds, sunrise and sunset as small tiles.
class WeatherDetailsGrid extends StatelessWidget {
  const WeatherDetailsGrid({super.key, required this.weather});

  final CurrentWeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      _Detail(
        Icons.water_drop_outlined,
        'weather.humidity'.tr(),
        '${weather.humidity}%',
      ),
      _Detail(
        Icons.air_rounded,
        'weather.wind'.tr(),
        'weather.wind_value'.tr(
          namedArgs: {'value': (weather.windSpeed * 3.6).round().toString()},
        ),
      ),
      _Detail(
        Icons.cloud_outlined,
        'weather.clouds'.tr(),
        '${weather.clouds}%',
      ),
      _Detail(
        Icons.grain_rounded,
        'weather.rain_last_hour'.tr(),
        'weather.mm_value'.tr(
          namedArgs: {'value': weather.rainLastHour.toStringAsFixed(1)},
        ),
      ),
      _Detail(
        Icons.wb_twilight_rounded,
        'weather.sunrise'.tr(),
        weather.sunrise.toAppTime(),
      ),
      _Detail(
        Icons.nights_stay_outlined,
        'weather.sunset'.tr(),
        weather.sunset.toAppTime(),
      ),
    ];

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        mainAxisExtent: 104.h,
      ),
      children: tiles.map((tile) => _DetailTile(detail: tile)).toList(),
    );
  }
}

class _Detail {
  const _Detail(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({required this.detail});

  final _Detail detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(detail.icon, size: 20.r, color: context.theme.primaryColor),
          Text(
            detail.label,
            style: context.textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            detail.value,
            style: context.textTheme.headlineMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
