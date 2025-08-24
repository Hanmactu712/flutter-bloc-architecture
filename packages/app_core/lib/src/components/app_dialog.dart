import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final Widget child;
  final String title;
  const AppDialog({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1,
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      title: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                text: title,
                style: context.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      content: child,
    );
  }
}
