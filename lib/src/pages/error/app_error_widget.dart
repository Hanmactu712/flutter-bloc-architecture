import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';
import 'package:flutter_bloc_architecture_template/src/localization/app_localizations.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final Function onBack;
  const AppErrorWidget({super.key, required this.message, required this.onBack});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(AppIcons.error, color: Theme.of(context).colorScheme.error, size: 64),
              const SizedBox(width: 8),
              AppText(text: locale.error, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          AppText(
            text: message,
            style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 20, fontWeight: FontWeight.bold),
            isFit: false,
            maxLines: 5,
          ),
          //back
          const SizedBox(height: 20),
          AppButton(
            text: locale.back,
            onPressed: () {
              onBack();
            },
          ),
        ],
      ),
    );
  }
}
