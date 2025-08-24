import 'package:flutter/material.dart';

class BoxContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final Function()? onTap;
  const BoxContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(6.0),
          border: border,
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          //     blurRadius: 6,
          //     offset: const Offset(4, 4),
          //   )
          // ],
        ),
        child: child,
      ),
    );
  }
}
