import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationWrapper extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  const NotificationWrapper({
    super.key,
    required this.builder,
  });

  _getColor(NotificationType type) {
    switch (type) {
      case NotificationType.error:
        return Colors.red;
      case NotificationType.success:
        return Colors.green;
      case NotificationType.warning:
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  _getBackgroundColor(NotificationType type) {
    switch (type) {
      case NotificationType.error:
        return Colors.red.shade100;
      case NotificationType.success:
        return Colors.green.shade100;
      case NotificationType.warning:
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(),
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                builder(context),
                if (state.notifications.isNotEmpty) ...[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var notification in state.notifications) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: _getBackgroundColor(notification.type),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _getIcon(notification.type),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: AppText(
                                        text: notification.message,
                                        style: context.bodyMedium!.copyWith(color: _getColor(notification.type)),
                                        isFit: false,
                                        maxLines: 2,
                                      ),
                                    ),
                                    //close icon
                                    GestureDetector(
                                      child: Icon(Icons.close, color: _getColor(notification.type)),
                                      onTap: () {
                                        context.read<NotificationCubit>().removeNotification(notification);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.error:
        return Icon(
          Icons.error,
          color: _getColor(type),
        );
      case NotificationType.success:
        return Icon(Icons.check, color: _getColor(type));
      case NotificationType.warning:
        return Icon(Icons.warning, color: _getColor(type));
      default:
        return Icon(Icons.info, color: _getColor(type));
    }
  }
}
