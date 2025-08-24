import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final ButtonStyle? style;
  final String type;
  final double? width;
  final double? height;
  final double radius;
  final IconData? prefixIcon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.style,
    this.type = 'primary',
    this.width,
    this.height = 40,
    this.radius = AbsoluteValues.xSmall,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: FilledButton.icon(
          onPressed: onPressed,
          style:
              style ??
              ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  type == 'primary'
                      ? Theme.of(context).colorScheme.primary
                      : type == 'secondary'
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : type == 'tertiary'
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Theme.of(context).colorScheme.primaryContainer,
                ),
                enableFeedback: true,
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
              ),
          icon:
              prefixIcon != null
                  ? Icon(
                    prefixIcon,
                    color:
                        type == 'primary'
                            ? Theme.of(context).colorScheme.onPrimary
                            : type == 'secondary'
                            ? Theme.of(context).colorScheme.onSecondaryContainer
                            : type == 'tertiary'
                            ? Theme.of(context).colorScheme.onTertiaryContainer
                            : Theme.of(context).colorScheme.onPrimaryContainer,
                  )
                  : null,
          label: AppText(
            text: text,
            style: context.titleMedium!.copyWith(
              color:
                  type == 'primary'
                      ? Theme.of(context).colorScheme.onPrimary
                      : type == 'secondary'
                      ? Theme.of(context).colorScheme.onSecondaryContainer
                      : type == 'tertiary'
                      ? Theme.of(context).colorScheme.onTertiaryContainer
                      : Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
