import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

enum AdaptiveLayoutId { topNavigation, body, bottomNavigation, leftNavigation, rightNavigation }

class LayoutConfig<T> {
  final T compactScreen;
  final T? mediumScreen;
  final T? expandedScreen;
  final T? largeScreen;
  final T? extraLargeScreen;

  const LayoutConfig({required this.compactScreen, this.mediumScreen, this.expandedScreen, this.largeScreen, this.extraLargeScreen});
}

class AdaptiveLayoutConfig extends LayoutConfig<Widget> {
  final Widget Function(Widget, Animation<double>)? inAnimation;
  final Widget Function(Widget, Animation<double>)? outAnimation;
  final Duration? duration;

  const AdaptiveLayoutConfig({
    this.inAnimation,
    this.outAnimation,
    this.duration,
    required super.compactScreen,
    super.mediumScreen,
    super.expandedScreen,
    super.largeScreen,
    super.extraLargeScreen,
  });
}

class AdaptiveLayout extends StatefulWidget {
  final AdaptiveLayoutConfig? topNavigation;
  final AdaptiveLayoutConfig body;
  final AdaptiveLayoutConfig? bottomNavigation;
  final AdaptiveLayoutConfig? leftNavigation;
  final AdaptiveLayoutConfig? rightNavigation;
  final double padding;
  final Duration? duration;
  final Orientation layoutOrientation;
  final AdaptiveLayoutConfig? drawer;
  final Color? backgroundColor;

  const AdaptiveLayout({
    super.key,
    required this.body,
    this.topNavigation,
    this.bottomNavigation,
    this.leftNavigation,
    this.rightNavigation,
    this.padding = 8,
    this.duration,
    this.layoutOrientation = Orientation.landscape,
    this.drawer,
    this.backgroundColor,
  });

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> with SingleTickerProviderStateMixin {
  final AppLogger _logger = AppLogger('AdaptiveLayout');

  late AnimationController _controller;
  final Set<AdaptiveLayoutId> isAnimating = {};
  late Map<AdaptiveLayoutId, Size> slotSizes;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration ?? const Duration(milliseconds: 600), vsync: this)..forward();

    slotSizes = {
      AdaptiveLayoutId.topNavigation: Size.zero,
      AdaptiveLayoutId.body: Size.zero,
      AdaptiveLayoutId.bottomNavigation: Size.zero,
      AdaptiveLayoutId.leftNavigation: Size.zero,
      AdaptiveLayoutId.rightNavigation: Size.zero,
    };

    _controller.addListener(() {
      // _logger.debug('Animation:', _controller.value);
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isAnimating.clear();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: widget.key,
      builder:
          (context, constraints) => OrientationBuilder(
            builder: (context, orientation) {
              var isDeviceChanged = Device.setDeviceDimension(constraints: constraints, orientation: orientation);

              _logger.debug('Device: ${Device.width}x${Device.height} - ${Device.deviceType}');

              var children = <Widget>[
                LayoutId(id: AdaptiveLayoutId.topNavigation.name, child: _getSlotWidget(widget.topNavigation)),
                LayoutId(id: AdaptiveLayoutId.body.name, child: _getSlotWidget(widget.body)),
                LayoutId(id: AdaptiveLayoutId.bottomNavigation.name, child: _getSlotWidget(widget.bottomNavigation)),
                LayoutId(id: AdaptiveLayoutId.leftNavigation.name, child: _getSlotWidget(widget.leftNavigation)),
                LayoutId(id: AdaptiveLayoutId.rightNavigation.name, child: _getSlotWidget(widget.rightNavigation)),
              ];

              var slotSizes = {
                AdaptiveLayoutId.topNavigation: Size.zero,
                AdaptiveLayoutId.body: Size.zero,
                AdaptiveLayoutId.bottomNavigation: Size.zero,
                AdaptiveLayoutId.leftNavigation: Size.zero,
                AdaptiveLayoutId.rightNavigation: Size.zero,
              };

              var appDrawer = _getDrawer(widget.drawer);

              var layouts =
                  children.map((e) {
                    var slot = e as LayoutId;
                    return slot.child;
                  }).toList();

              if (isDeviceChanged) {
                _controller.reset();
                _controller.forward();
              }

              return SafeArea(
                child: Scaffold(
                  drawer: appDrawer,
                  backgroundColor: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
                  body: Container(
                    // constraints: const BoxConstraints(minWidth: 500.0),
                    padding: EdgeInsets.all(widget.padding),
                    child: CustomMultiChildLayout(
                      delegate: _AdaptiveLayoutDelegate(
                        orientation: widget.layoutOrientation,
                        animationController: _controller,
                        slotSizes: slotSizes,
                        layouts: layouts,
                      ),
                      children: children,
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget? _getDrawer(AdaptiveLayoutConfig? config) {
    if (config == null) {
      return null;
    }
    if (Device.mediumScreen) {
      return config.mediumScreen;
    } else if (Device.expandedScreen) {
      return config.expandedScreen;
    } else if (Device.largeScreen) {
      return config.largeScreen;
    } else if (Device.extraLargeScreen) {
      return config.extraLargeScreen;
    } else {
      return config.compactScreen;
    }
  }

  Widget _getSlotWidget(AdaptiveLayoutConfig? config) {
    late Widget child;
    if (config == null) {
      child = const SizedBox();
    } else {
      if (Device.mediumScreen) {
        child = config.mediumScreen ?? config.compactScreen;
      } else if (Device.expandedScreen) {
        child = config.expandedScreen ?? config.mediumScreen ?? config.compactScreen;
      } else if (Device.largeScreen) {
        child = config.largeScreen ?? config.expandedScreen ?? config.mediumScreen ?? config.compactScreen;
      } else if (Device.extraLargeScreen) {
        child = config.extraLargeScreen ?? config.largeScreen ?? config.expandedScreen ?? config.mediumScreen ?? config.compactScreen;
      } else {
        child = config.compactScreen;
      }
    }

    return AdaptiveLayoutSlot(inAnimation: config?.inAnimation, outAnimation: config?.outAnimation, duration: config?.duration, child: child);
  }
}

//delegate for AdaptiveLayout
class _AdaptiveLayoutDelegate extends MultiChildLayoutDelegate {
  final Orientation orientation;
  final AnimationController animationController;
  final Map<AdaptiveLayoutId, Size> slotSizes;
  final List<Widget> layouts;

  _AdaptiveLayoutDelegate({required this.orientation, required this.animationController, required this.slotSizes, required this.layouts})
    : super(relayout: animationController);

  final _logger = AppLogger('_AdaptiveLayoutDelegate');

  _updateSize(AdaptiveLayoutId id, Size size) {
    if (slotSizes[id] != size) {
      void listener(AnimationStatus status) {
        if ((status == AnimationStatus.completed || status == AnimationStatus.dismissed) && slotSizes[id] != size) {
          slotSizes[id] = size;
          animationController.removeStatusListener(listener);
        }
      }

      animationController.addStatusListener(listener);
    }
  }

  Size _animatedSize(Size begin, Size end) {
    return Tween<Size>(begin: begin, end: end).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOutCubic)).value;
  }

  @override
  void performLayout(Size size) {
    double leftMargin = 0;
    double topMargin = 0;
    double rightMargin = 0;
    double bottomMargin = 0;

    if (hasChild(AdaptiveLayoutId.topNavigation.name)) {
      final childSize = layoutChild(AdaptiveLayoutId.topNavigation.name, BoxConstraints.loose(size));

      _updateSize(AdaptiveLayoutId.topNavigation, childSize);

      var currentSize = Tween<Size>(begin: slotSizes[AdaptiveLayoutId.topNavigation] ?? Size.zero, end: childSize).animate(animationController).value;

      positionChild(AdaptiveLayoutId.topNavigation.name, Offset(leftMargin, topMargin));

      // _logger.debug('Layout: ${AdaptiveLayoutId.topNavigation.name} - ${childSize.width}x${childSize.height}', slotSizes[AdaptiveLayoutId.topNavigation]);
      topMargin += currentSize.height;
    }

    if (hasChild(AdaptiveLayoutId.bottomNavigation.name)) {
      final childSize = layoutChild(AdaptiveLayoutId.bottomNavigation.name, BoxConstraints.loose(Size(size.width, size.height - topMargin)));

      _updateSize(AdaptiveLayoutId.bottomNavigation, childSize);

      positionChild(AdaptiveLayoutId.bottomNavigation.name, Offset(leftMargin, size.height - childSize.height));

      var currentSize = Tween<Size>(begin: slotSizes[AdaptiveLayoutId.bottomNavigation] ?? Size.zero, end: childSize).animate(animationController).value;

      bottomMargin += currentSize.height;

      // _logger.debug('Layout: ${AdaptiveLayoutId.bottomNavigation.name} - ${childSize.width}x${childSize.height}');
    }

    if (hasChild(AdaptiveLayoutId.leftNavigation.name)) {
      final childSize = layoutChild(AdaptiveLayoutId.leftNavigation.name, BoxConstraints.loose(Size(size.width, size.height - topMargin - bottomMargin)));

      _updateSize(AdaptiveLayoutId.leftNavigation, childSize);

      var currentSize = Tween<Size>(begin: slotSizes[AdaptiveLayoutId.leftNavigation] ?? Size.zero, end: childSize).animate(animationController).value;

      //log current size
      // _logger.debug('Child Size: ${AdaptiveLayoutId.leftNavigation.name}', childSize);

      positionChild(AdaptiveLayoutId.leftNavigation.name, Offset(leftMargin, topMargin));
      leftMargin += currentSize.width;

      // _logger.debug('Layout: ${AdaptiveLayoutId.leftNavigation.name} - ${childSize.width}x${childSize.height}');
    }

    if (hasChild(AdaptiveLayoutId.rightNavigation.name)) {
      final childSize = layoutChild(
        AdaptiveLayoutId.rightNavigation.name,
        BoxConstraints.loose(Size(size.width - leftMargin, size.height - topMargin - bottomMargin)),
      );

      _updateSize(AdaptiveLayoutId.rightNavigation, childSize);

      var currentSize = Tween<Size>(begin: slotSizes[AdaptiveLayoutId.rightNavigation] ?? Size.zero, end: childSize).animate(animationController).value;

      positionChild(AdaptiveLayoutId.rightNavigation.name, Offset(size.width - childSize.width, topMargin));

      rightMargin += currentSize.width;

      // _logger.debug('Layout: ${AdaptiveLayoutId.rightNavigation.name} - ${childSize.width}x${childSize.height}');
    }

    var remainingWidth = size.width - leftMargin - rightMargin;
    var remainingHeight = size.height - topMargin - bottomMargin;

    if (hasChild(AdaptiveLayoutId.body.name)) {
      var containerSize = Size(remainingWidth, remainingHeight);

      layoutChild(AdaptiveLayoutId.body.name, BoxConstraints.loose(_animatedSize(Size(remainingWidth, remainingHeight), containerSize)));

      positionChild(AdaptiveLayoutId.body.name, Offset(leftMargin, topMargin));
      // _logger.debug('Layout: ${AdaptiveLayoutId.body.name} - landscape - ${containerSize.width}x${containerSize.height}');
    }
  }

  @override
  bool shouldRelayout(_AdaptiveLayoutDelegate oldDelegate) {
    var relayout = oldDelegate.layouts != layouts;
    _logger.debug('Relayout:', relayout);
    return relayout;
  }
}
