import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageOrDefault {
  static Widget build(BuildContext context, String? url, {BoxFit fit = BoxFit.cover, Widget? placeholder, Widget? errorWidget}) {
    if (url == null || url.isEmpty) {
      return Placeholder(
        color: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.error, color: Theme.of(context).colorScheme.secondary),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      color: Theme.of(context).colorScheme.secondary,
      useOldImageOnUrlChange: true,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => placeholder ?? const Center(child: CircularProgressIndicator.adaptive()),
      errorWidget: (context, url, error) => errorWidget ?? Icon(Icons.error, color: Theme.of(context).colorScheme.surface),
    );
  }
}
