import 'dart:developer';

import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  final Widget child;
  final AppBar? appBar;
  final Widget? bottomSheet;
  final Widget? floatingActionButton;
  final Drawer? drawer;
  final double? minHeight;
  const AppPage({
    super.key,
    required this.child,
    this.appBar,
    this.bottomSheet,
    this.minHeight,
    this.drawer,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomSheet: bottomSheet,
      body: minHeight != null
          ? LayoutBuilder(
              builder: (context, constraints) {
                final pageHeight = constraints.maxHeight < minHeight! ? minHeight : constraints.maxHeight;
                log('pageHeight: $pageHeight');
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      constraints: const BoxConstraints(minHeight: 200, minWidth: 200),
                      height: pageHeight,
                      child: child,
                    ),
                  ],
                );
                // return child: child;
              },
            )
          : child,
      floatingActionButton: floatingActionButton,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
