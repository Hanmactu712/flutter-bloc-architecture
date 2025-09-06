import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AppListView extends StatelessWidget {
  final List<Widget> children;
  final Axis scrollDirection;
  final LayoutConfig<int> columnConfig;
  final LayoutConfig<double> gapConfig;
  const AppListView({
    super.key,
    required this.children,
    this.scrollDirection = Axis.vertical,
    this.columnConfig = const LayoutConfig<int>(compactScreen: 1, expandedScreen: 2, largeScreen: 2, extraLargeScreen: 3),
    this.gapConfig = const LayoutConfig<double>(compactScreen: 8, expandedScreen: 12, largeScreen: 16),
  });

  @override
  Widget build(BuildContext context) {
    var logger = AppLogger('AppListView');

    return LayoutBuilder(
      builder: (context, constraints) {
        var columns = getConfigValue<int>(columnConfig);
        var spacing = getConfigValue<double>(gapConfig);

        logger.debug('columns: $columns spacing: $spacing children: ${children.length}');

        return MasonryGridView.count(
          crossAxisCount: columns,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          shrinkWrap: true,
          itemCount: children.length,
          itemBuilder: (context, index) {
            return index < children.length ? children[index] : Container();
          },
        );
      },
    );
  }
}
