import 'package:weathera/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_page.dart';

class MainScreen extends StatefulWidget {
  final String section;

  const MainScreen({super.key, required this.section});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<Widget> pages = [const HomePage()];

  Map<int, String> indexToSectionMap = {0: AppPaths.main.home};

  int sectionToIndex(String section) {
    Map<String, int> sectionToIndexMap = indexToSectionMap.map(
      (k, v) => MapEntry(v, k),
    );

    return sectionToIndexMap[section] ?? 0;
  }

  String indexToSection(int index) {
    return indexToSectionMap[index] ?? AppPaths.main.home;
  }

  @override
  Widget build(BuildContext context) {
    int currentPageIndex = sectionToIndex(widget.section);

    return PopScope(
      canPop: currentPageIndex == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(AppPaths.main.home);
      },
      child: Scaffold(key: _scaffoldKey, body: pages[currentPageIndex]),
    );
  }
}
