import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatefulWidget {
  final Widget compactScreen;
  final Widget? mediumScreen;
  final Widget? expandedScreen;
  final Widget? largeScreen;
  final Widget? extraLargeScreen;
  final Widget Function(Widget, Animation<double>)? inAnimation;
  final Widget Function(Widget, Animation<double>)? outAnimation;
  final Duration? duration;
  const ResponsiveWidget({
    super.key,
    required this.compactScreen,
    this.mediumScreen,
    this.expandedScreen,
    this.largeScreen,
    this.extraLargeScreen,
    this.inAnimation,
    this.outAnimation,
    this.duration,
  });

  @override
  State<ResponsiveWidget> createState() => _ResponsiveWidgetState();
}

class _ResponsiveWidgetState extends State<ResponsiveWidget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var innerInAnimation = widget.inAnimation ?? (child, animation) => FadeTransition(opacity: animation, child: child);
    var innerOutAnimation = widget.outAnimation ?? (child, animation) => FadeTransition(opacity: animation, child: child);
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedSwitcher(
        duration: widget.duration ?? const Duration(milliseconds: 600),
        child: _buildChild(),
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            children: <Widget>[
              if (previousChildren.isNotEmpty) previousChildren.first,
              if (currentChild != null) currentChild,
            ],
          );
        },
        transitionBuilder: (child, animation) {
          if (child.key == _buildChild().key) {
            return innerInAnimation(child, animation);
          } else {
            return innerOutAnimation(child, ReverseAnimation(animation));
          }
        },
      );
    });
  }

  _buildChild() {
    if (Device.mediumScreen) return widget.mediumScreen ?? widget.compactScreen;
    if (Device.expandedScreen) return widget.expandedScreen ?? widget.mediumScreen ?? widget.compactScreen;
    if (Device.largeScreen) return widget.largeScreen ?? widget.expandedScreen ?? widget.mediumScreen ?? widget.compactScreen;
    if (Device.extraLargeScreen) return widget.extraLargeScreen ?? widget.largeScreen ?? widget.expandedScreen ?? widget.mediumScreen ?? widget.compactScreen;
    return widget.compactScreen;
  }
}
