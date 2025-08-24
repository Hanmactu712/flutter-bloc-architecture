import 'package:app_core/app_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), offset: const Offset(0, -1), blurRadius: 4)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [InkWell(onTap: () {}, child: const AppText(text: "Privacy Policy")), const AppText(text: "@2024 ducdang.dev")],
          ),
        )
        : const SizedBox.shrink();
  }
}
