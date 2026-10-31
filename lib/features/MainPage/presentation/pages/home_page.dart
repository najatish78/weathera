import 'package:weathera/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Placeholder until the weather feature is built.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text("home.title".tr(), style: context.textTheme.displayMedium),
      ),
    );
  }
}
