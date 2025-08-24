enum NotificationType {
  message,
  error,
  warning,
  success,
}

class NotificationMessage {
  final String message;
  final int duration;
  final NotificationType type;

  NotificationMessage({
    required this.message,
    this.type = NotificationType.message,
    this.duration = 3,
  });

  //copy with
  NotificationMessage copyWith({
    String? message,
    NotificationType? type,
    int? duration,
  }) {
    return NotificationMessage(
      message: message ?? this.message,
      type: type ?? this.type,
      duration: duration ?? this.duration,
    );
  }

  factory NotificationMessage.fromJson(Map<String, dynamic> json) {
    return NotificationMessage(
      message: json['message'] ?? '',
      type: json['type'] ?? NotificationType.message,
      duration: json['duration'] ?? 3,
    );
  }
}
