import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_template/src/pages/pages.dart';

import 'app_menu_item.dart';

class AppMenuRail extends StatelessWidget {
  final LayoutConfig<double> widthConfig;
  final bool isExpanded;

  const AppMenuRail({
    super.key,
    this.isExpanded = false,
    this.widthConfig = const LayoutConfig<double>(compactScreen: 60, expandedScreen: 60, largeScreen: 240),
  });

  double _getWidth(LayoutConfig<double> config) {
    if (Device.mediumScreen) {
      return config.mediumScreen ?? config.compactScreen;
    } else if (Device.expandedScreen) {
      return config.expandedScreen ?? config.mediumScreen ?? config.compactScreen;
    } else if (Device.largeScreen) {
      return config.largeScreen ?? config.expandedScreen ?? config.mediumScreen ?? config.compactScreen;
    } else if (Device.extraLargeScreen) {
      return config.extraLargeScreen ?? config.largeScreen ?? config.expandedScreen ?? config.mediumScreen ?? config.compactScreen;
    } else {
      return config.compactScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                var isCompact = isExpanded ? false : (Device.compactScreen || Device.mediumScreen || Device.expandedScreen);
                var width = _getWidth(widthConfig);
                return AnimatedContainer(
                  width: width,
                  duration: const Duration(milliseconds: 400),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: AppListView(
                    columnConfig: const LayoutConfig<int>(compactScreen: 1),
                    children: [
                      AppMenuItem(icon: AppIcons.home, text: "Home", routeTo: HomePage.routeItem, iconOnly: isCompact),
                      const Divider(),

                      AppMenuItem(icon: AppIcons.add, text: "Sample Page", routeTo: SamplePage.routeItem, iconOnly: isCompact),
                      AppMenuItem(icon: AppIcons.edit, text: "Sample Page", routeTo: SamplePage.routeItem, iconOnly: isCompact),
                      AppMenuItem(icon: AppIcons.search, text: "Sample Page", routeTo: SamplePage.routeItem, iconOnly: isCompact),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
