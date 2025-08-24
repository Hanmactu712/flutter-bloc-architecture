import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/notification_message.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  Timer? _timer;
  NotificationCubit() : super(const NotificationState()) {
    //initialize interval timer to clear notifications
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateNotifications();
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void addNotification(NotificationMessage notification) {
    var notifications = state.notifications;
    notifications = [...notifications, notification];
    emit(NotificationState(notifications: notifications));
  }

  void _updateNotifications() {
    if (state.notifications.isEmpty) return;

    var notifications = state.notifications.map((e) {
      if (e.duration > 0) {
        return e.copyWith(duration: e.duration - 1);
      } else {
        return e;
      }
    });

    var newNotifications = notifications.where((element) => element.duration > 0).toList();
    emit(NotificationState(notifications: newNotifications));
  }

  void removeNotification(NotificationMessage notification) {
    var notifications = state.notifications.where((element) => element != notification).toList();
    emit(NotificationState(notifications: notifications));
  }
}
