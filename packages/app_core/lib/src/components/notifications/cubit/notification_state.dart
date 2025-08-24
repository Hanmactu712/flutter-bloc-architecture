part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final List<NotificationMessage> notifications;
  const NotificationState({this.notifications = const <NotificationMessage>[]});

  @override
  List<Object> get props => [notifications];
}
