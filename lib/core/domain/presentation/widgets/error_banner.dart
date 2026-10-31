import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/failures/base_failure.dart';
import '../../../utils/parse_helpers/failure_parser.dart';

class ErrorBanner extends StatelessWidget {
  final Failure failure;
  final Color? color;
  final VoidCallback? tryAgain;

  /// Gap between the warning icon and the message text. Defaults to the
  /// original 10px spacing so existing call sites are unaffected.
  final double? iconTextSpacing;

  /// When true, the message text sits left/start-aligned right after the
  /// icon instead of being centered within its own flexible slot (which,
  /// for short messages, can visually strand it away from the icon).
  /// Defaults to false to preserve existing call sites' appearance.
  final bool alignTextToIcon;

  /// When provided, shown instead of the message derived from [failure] —
  /// e.g. a caller ticking its own live countdown text for a
  /// [RateLimitedFailure] rather than the static message baked into it.
  final String? overrideMessage;

  const ErrorBanner({
    super.key,
    required this.failure,
    this.tryAgain,
    this.color,
    this.iconTextSpacing,
    this.alignTextToIcon = false,
    this.overrideMessage,
  });

  @override
  Widget build(BuildContext context) {
    final message = Text(
      overrideMessage ??
          FailureParser.mapFailureToString(failure: failure, context: context),
      style: TextStyle(color: Theme.of(context).colorScheme.error),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.withValues(alpha: .2),
        ),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
              SizedBox(width: iconTextSpacing ?? 10.w),
              Expanded(
                flex: 4,
                child: alignTextToIcon ? message : Center(child: message),
              ),
              if (tryAgain != null)
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.refresh, color: Colors.red.shade200),
                    onPressed: tryAgain,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
