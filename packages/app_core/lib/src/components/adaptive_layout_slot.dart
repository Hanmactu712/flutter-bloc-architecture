import 'package:flutter/material.dart';

class AdaptiveLayoutSlot extends StatefulWidget {
  final Widget child;
  final Widget Function(Widget, Animation<double>)? inAnimation;
  final Widget Function(Widget, Animation<double>)? outAnimation;
  final Duration? duration;

  const AdaptiveLayoutSlot({
    Key? key,
    required this.child,
    this.inAnimation,
    this.outAnimation,
    this.duration,
  }) : super(key: key);

  @override
  State<AdaptiveLayoutSlot> createState() => _AdaptiveLayoutSlotState();
}

class _AdaptiveLayoutSlotState extends State<AdaptiveLayoutSlot> with SingleTickerProviderStateMixin {
  // final AppLogger _logger = AppLogger('AdaptiveLayoutSlot');
  @override
  Widget build(BuildContext context) {
    bool hasOutAnimation = false;
    // _logger.debug('build - hasOutAnimation', hasOutAnimation);
    return AnimatedSwitcher(
      duration: widget.duration ?? const Duration(milliseconds: 500),
      child: widget.child,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          children: <Widget>[
            if (hasOutAnimation && previousChildren.isNotEmpty) previousChildren.first,
            if (currentChild != null) currentChild,
          ],
        );
      },
      transitionBuilder: (child, animation) {
        if (child.key == widget.child.key) {
          return widget.inAnimation != null ? widget.inAnimation!(child, animation) : child;
        } else {
          if (widget.outAnimation != null) {
            hasOutAnimation = true;
          }
          return widget.outAnimation != null ? widget.outAnimation!(child, ReverseAnimation(animation)) : child;
        }
      },
    );
  }
}
