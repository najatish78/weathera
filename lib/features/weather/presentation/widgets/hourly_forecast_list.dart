import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weathera/core/domain/presentation/resources/theme/app_color_scheme.dart';
import 'package:weathera/core/utils/extentions.dart';
import 'package:weathera/features/weather/data/model/forecast_model.dart';

/// Next 24 hours in 3-hour steps: time, icon, temperature, rain chance.
class HourlyForecastList extends StatelessWidget {
  const HourlyForecastList({super.key, required this.items});

  final List<ForecastItemModel> items;

  @override
  Widget build(BuildContext context) {
    final next = items.take(8).toList();
    return SizedBox(
      height: 130.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: next.length,
        separatorBuilder: (_, _) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final item = next[index];
          return Container(
            width: 70.w,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: context.theme.dividerColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.time.toAppTime(), style: context.textTheme.bodySmall),
                CachedNetworkImage(
                  imageUrl: item.condition.iconUrl,
                  width: 40.r,
                  height: 40.r,
                  errorWidget: (_, _, _) => const SizedBox.shrink(),
                ),
                Text(
                  '${item.temp.round()}°',
                  style: context.textTheme.headlineMedium,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.water_drop_rounded,
                      size: 12.r,
                      color: WeatheraPalette.rainy,
                    ),
                    Text(
                      '${(item.rainChance * 100).round()}%',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
