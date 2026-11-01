import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weathera/core/domain/presentation/widgets/error_banner.dart';
import 'package:weathera/core/domain/presentation/widgets/loading_banner.dart';
import 'package:weathera/core/utils/extentions.dart';
import 'package:weathera/features/outfit/data/model/outfit_suggestion_model.dart';
import 'package:weathera/features/outfit/presentation/cubits/outfit_cubit/outfit_cubit.dart';

/// "What to wear" card under the current weather.
class OutfitCard extends StatelessWidget {
  const OutfitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OutfitCubit, OutfitState>(
      builder: (context, state) {
        final data = state.data;
        if (data != null) return _Suggestion(outfit: data);
        if (state.status == OutfitStatus.error) {
          return ErrorBanner(
            failure: state.failure!,
            tryAgain: context.read<OutfitCubit>().retry,
          );
        }
        return _Frame(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Column(
              children: [
                const LoadingBanner(size: 32),
                SizedBox(height: 12.h),
                Text('outfit.loading'.tr(), style: context.textTheme.bodySmall),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Suggestion extends StatelessWidget {
  const _Suggestion({required this.outfit});

  final OutfitSuggestionModel outfit;

  @override
  Widget build(BuildContext context) {
    final jacket = outfit.jacket;
    return _Frame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Item(label: 'outfit.top'.tr(), value: outfit.top),
          _Item(label: 'outfit.bottom'.tr(), value: outfit.bottom),
          _Item(label: 'outfit.shoes'.tr(), value: outfit.shoes),
          if (jacket != null) _Item(label: 'outfit.jacket'.tr(), value: jacket),
          if (outfit.umbrella || outfit.sunscreen) ...[
            SizedBox(height: 4.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                if (outfit.umbrella)
                  _Reminder(
                    icon: Icons.umbrella_rounded,
                    label: 'outfit.umbrella'.tr(),
                  ),
                if (outfit.sunscreen)
                  _Reminder(
                    icon: Icons.wb_sunny_rounded,
                    label: 'outfit.sunscreen'.tr(),
                  ),
              ],
            ),
          ],
          if (outfit.reason.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(outfit.reason, style: context.textTheme.bodyMedium),
          ],
          if (!outfit.fromLlm) ...[
            SizedBox(height: 8.h),
            Text(
              'outfit.fallback_note'.tr(),
              style: context.textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}

class _Frame extends StatelessWidget {
  const _Frame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: child,
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 72.w,
            child: Text(label, style: context.textTheme.bodySmall),
          ),
          Expanded(child: Text(value, style: context.textTheme.headlineMedium)),
        ],
      ),
    );
  }
}

class _Reminder extends StatelessWidget {
  const _Reminder({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.primaryColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16.r),
          SizedBox(width: 4.w),
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
