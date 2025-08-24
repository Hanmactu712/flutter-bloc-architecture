import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void goToUrl(String? url) async {
  if (url == null || url.isEmpty) return;
  var uri = Uri.parse(url);
  if (!await launchUrl(uri, webOnlyWindowName: '_blank')) {
    // log('Could not launch $url');
  }
}

T getConfigValue<T>(LayoutConfig<T> config) {
  var deviceType = Device.deviceType;
  if (deviceType == DeviceType.compactScreen) {
    return config.compactScreen;
  } else if (deviceType == DeviceType.mediumScreen) {
    return config.mediumScreen ?? config.compactScreen;
  } else if (deviceType == DeviceType.expandedScreen) {
    return config.expandedScreen ?? config.mediumScreen ?? config.compactScreen;
  } else if (deviceType == DeviceType.largeScreen) {
    return config.largeScreen ?? config.expandedScreen ?? config.mediumScreen ?? config.compactScreen;
  } else if (deviceType == DeviceType.extraLargeScreen) {
    return config.extraLargeScreen ?? config.largeScreen ?? config.expandedScreen ?? config.mediumScreen ?? config.compactScreen;
  } else {
    return config.compactScreen;
  }
}

enum MessageType { error, success, warning }

class SnackBarUtils {
  static void showSnackBar(
    BuildContext context,
    String message, {
    MessageType type = MessageType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    var color = type == MessageType.error
        ? Theme.of(context).colorScheme.error
        : type == MessageType.warning
            ? Colors.orange.shade100
            : Colors.green.shade100;

    var textColor = type == MessageType.error
        ? Theme.of(context).colorScheme.onError
        : type == MessageType.warning
            ? Colors.orange.shade700
            : Colors.green.shade700;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: AppText(
          text: message,
          style: context.labelMedium!.copyWith(color: textColor),
        ),
        duration: duration,
      ),
    );
  }
}
